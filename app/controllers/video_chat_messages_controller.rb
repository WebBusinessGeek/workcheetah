class VideoChatMessagesController < ApplicationController
	before_filter :authenticate_user!

  def create
  	@video_chat_message = VideoChatMessage.new(params[:video_chat_message])
  	@video_chat_message.sender = current_user

  	if @video_chat_message.save!
  	  render "create", handlers: [ "js.erb" ]
  	else
  	  return false
  	end
  end
end
