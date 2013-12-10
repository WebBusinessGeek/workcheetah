class ConversationsController < ApplicationController
	before_filter :user_signed_in?

	def index
		@conversations = current_user.conversations.order("id DESC")
	end

	def sent
		@conversations = ConversationItem.where("sender_id = ? and draft = false",current_user.id).select('DISTINCT ON (conversation_id) *').order('conversation_id desc,created_at desc')
	end

	def draft
		@conversations = ConversationItem.where("sender_id = ? and draft = true",current_user.id).select('DISTINCT ON (conversation_id) *').order('conversation_id desc,created_at desc')
	end

	def show
		@conversation = Conversation.find(params[:id])
		@draft = @conversation.conversation_items.find_by_sender_id_and_draft(current_user.id,true)
		if @draft.present?
			@new_conversation = @draft
		else
			@new_conversation = @conversation.conversation_items.build
		end
		if !@conversation.participants.where(user_id: current_user).any?
			redirect_to :back, notice: "This is not your conversation."
		end
	end

	def new
		if !current_user.account.present? and !current_user.admin? and !current_user.moderator?
			redirect_to :back, notice: "Only employers can initiate conversations." and return
		end

		@users = current_user.contact_list

		@conversation = Conversation.new
	end

	def create
		if !current_user.account.present? and !current_user.admin? and !current_user.moderator?
			redirect_to :back, notice: "Only employers can initiate conversations." and return
		end

		@conversation = Conversation.create(subject: params[:conversation][:subject])

		@message = @conversation.conversation_items.build(params[:conversation][:conversation_item])
		@message.sender = current_user

		if @message.save
			@conversation.participants.create(user_id: params[:conversation][:recipient_id])
			@conversation.participants.create(user_id: current_user.id)
			redirect_to @conversation
		else
			render action: :new, recipient_id: params[:recipient_id]
		end

		begin
			@conversation.participants.each do |participant|
				NotificationMailer.delay.new_conversation(@conversation, participant.user).deliver if participant.user.email != current_user.email
			end
		rescue Exception => e
			logger.info "Mails could not be sent after creation of conversation with id #{@conversation.id}"
		end
	end

	def update
		@conversation = Conversation.find(params[:id])

		@conversation.participants.each do |participant|
			if participant.user.blocks?(current_user)
				redirect_to :back, notice: "That user is blocking you. You cannot send a message to that user." and return
				break
			end
		end

		@draft = @conversation.conversation_items.find_by_sender_id_and_draft(current_user.id,true)
		if @draft.present?
			@draft.destroy
		end

		if params[:commit].present? and params[:commit].downcase == 'send'
			conversation_item = @conversation.conversation_items.build(params[:conversation][:conversation_item].merge(sender_id: current_user.id, draft: false))
		else
			conversation_item = @conversation.conversation_items.build(params[:conversation][:conversation_item].merge(sender_id: current_user.id, draft: true))
		end

		conversation_item.sender = current_user
		if conversation_item.save
			redirect_to @conversation
			unless conversation_item.draft == true
				begin
					@conversation.participants.each do |participant|
						NotificationMailer.delay.new_conversation(@conversation, participant.user).deliver if participant.user.email != current_user.email
					end
				rescue Exception => e
					logger.info "Mails could not be sent after update of conversation with id #{@conversation.id}"
				end
			end
		else
			render action: :show
		end
	end

	def send_to_all
		redirect_to :back and return false unless current_user.admin

		User.find_each do |user|
			if user.id != current_user.id
				conversation = Conversation.create(subject: params[:conversation][:subject])
				conversation.participants.create(user_id: current_user.id)
				conversation.participants.create(user_id: user.id)
				conversation_item = conversation.conversation_items.build(params[:conversation][:conversation_item])
				conversation_item.sender = current_user
				conversation_item.save

				NotificationMailer.delay.new_conversation(conversation, user).deliver
			end
		end

		redirect_to :back, notice: "Successfully sent message to everyone."
	end
end
