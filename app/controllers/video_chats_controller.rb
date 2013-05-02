class VideoChatsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /video_chats
  # GET /video_chats.json
  def index
    @video_chats = VideoChat.where("recipient_id = ? OR requester_id = ?", current_user.id, current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @video_chats }
    end
  end

  # GET /video_chats/1
  # GET /video_chats/1.json
  def show
  end

  # GET /video_chats/new
  # GET /video_chats/new.json
  def new
    return redirect_to :back unless params[:recipient_id]
    @recipient = User.find(params[:recipient_id])

    @video_chat = VideoChat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video_chat }
    end
  end

  # GET /video_chats/1/edit
  def edit
  end

  # POST /video_chats
  # POST /video_chats.json
  def create
    @video_chat = VideoChat.new(video_chat_params)
    @video_chat.requester = current_user
    @video_chat.accepted_by_requester = true
    @video_chat.accepted_by_recipient = false

    respond_to do |format|
      if @video_chat.save
        NotificationMailer.new_video_chat(@video_chat).deliver
        format.html { redirect_to @video_chat, notice: 'Video chat was successfully created.' }
        format.json { render json: @video_chat, status: :created, location: @video_chat }
      else
        format.html { render action: "new" }
        format.json { render json: @video_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_chats/1
  # PATCH/PUT /video_chats/1.json
  def update
    @video_chat = VideoChat.find(params[:id])
    if current_user == @video_chat.recipient
      @video_chat.accepted_by_recipient = true
      @video_chat.accepted_by_requester = false
      mail_recipient = @video_chat.requester
    else
      @video_chat.accepted_by_requester = true
      @video_chat.accepted_by_recipient = false
      mail_recipient = @video_chat.recipient
    end

    respond_to do |format|
      if @video_chat = @video_chat.update_attributes(video_chat_params)
        NotificationMailer.video_chat_update(@video_chat, mail_recipient).deliver
        format.html { redirect_to @video_chat, notice: 'Video chat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_chats/1
  # DELETE /video_chats/1.json
  def destroy
    @video_chat = VideoChat.find(params[:id])

    if current_user == @video_chat.requester
      mail_recipient = @video_chat.recipient
    else
      mail_recipient = @video_chat.requester
    end

    NotificationMailer.video_chat_cancellation(@video_chat, mail_recipient).deliver

    @video_chat.destroy

    respond_to do |format|
      format.html { redirect_to video_chats_url, notice: "Video interview cancelled. Your interview partner has been notified." }
      format.json { head :no_content }
    end
  end

  def accept
    @video_chat = VideoChat.find(params[:id])
    if current_user = @video_chat.recipient
      @video_chat.accepted_by_recipient = true
      mail_recipient = @video_chat.requester
    else
      @video_chat.accepted_by_requester = true
      mail_recipient = @video_chat.recipient
    end

    if @video_chat.save
      NotificationMailer.accept_video_chat(@video_chat, mail_recipient).deliver
      redirect_to @video_chat, notice: "Your interview partner has been notified about you accepting the interview schedule."
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def video_chat_params
      params.require(:video_chat).permit(:accepted_by_recipient, :accepted_by_requester, :end_time, :recipient_id, :requester_id, :start_time)
    end
end
