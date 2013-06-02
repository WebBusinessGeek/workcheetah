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
		if !current_user.account.present?
			redirect_to :back, notice: "Only employers can initiate conversations." and return
		end

		@conversation = Conversation.new
		@recipient = User.find(params[:recipient_id])
	end

	def create
		if !current_user.account.present?
			redirect_to :back, notice: "Only employers can initiate conversations." and return
		end

		if !current_user.account.safe_job_seal?
			redirect_to :back, notice: "Please validate your company in order to be able to send messages to your recruits." and return
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
	end

	def update
		@conversation = Conversation.find(params[:id])
		# raise params.inspect
		conversation_item = @conversation.conversation_items.build(params[:conversation][:conversation_item], sender_id: current_user)
		conversation_item.sender = current_user
		if conversation_item.save
			redirect_to @conversation
		else
			render action: :show
		end
	end
end