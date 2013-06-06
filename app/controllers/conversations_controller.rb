class ConversationsController < ApplicationController
	before_filter :user_signed_in?

	def index
		@conversations = current_user.conversations
	end

	def show
		@conversation = Conversation.find(params[:id])
		if !@conversation.participants.where(user_id: current_user).any?
			redirect_to :back, notice: "This is not your conversation."
		end
	end

	def new
		if !current_user.account.present? and !current_user.admin? and !current_user.moderator?
			redirect_to :back, notice: "Only employers can initiate conversations." and return
		end

		@conversation = Conversation.new
		@recipient = User.find(params[:recipient_id])

		if @recipient.blocks?(current_user)
			redirect_to :back, notice: "That user is blocking you. You cannot send a message to that user." and return
		end
	end

	def create
		if !current_user.account.present? and !current_user.admin? and !current_user.moderator?
			redirect_to :back, notice: "Only employers can initiate conversations." and return
		end

		if current_user.account.present? and !current_user.account.safe_job_seal?
			redirect_to :back, notice: "Please validate your company in order to be able to send messages to your recruits." and return
		end

		if User.find(params[:conversation][:recipient_id]).blocks?(current_user)
			redirect_to :back, notice: "That user is blocking you. You cannot send a message to that user." and return
		end

		@conversation = Conversation.create
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
				NotificationMailer.new_conversation(@conversation, participant.user).deliver if participant.user.email != current_user.email
			end
		rescue Exception => e
			logger.info "Mails could not be sent after creation of conversation with id #{@conversation.id}"
		end
	end

	def update
		if current_user.account.present? and !current_user.account.safe_job_seal?
			redirect_to :back, notice: "Please validate your company in order to be able to send messages to your recruits." and return
		end
		
		@conversation = Conversation.find(params[:id])

		@conversation.participants.each do |participant|
			if participant.user.blocks?(current_user)
				redirect_to :back, notice: "That user is blocking you. You cannot send a message to that user." and return
				break
			end
		end

		conversation_item = @conversation.conversation_items.build(params[:conversation][:conversation_item], sender_id: current_user)
		conversation_item.sender = current_user
		if conversation_item.save
			redirect_to @conversation

			begin
				@conversation.participants.each do |participant|
					NotificationMailer.new_conversation(@conversation, participant.user).deliver if participant.user.email != current_user.email
				end
			rescue Exception => e
				logger.info "Mails could not be sent after update of conversation with id #{@conversation.id}"
			end
		else
			render action: :show
		end
	end
end