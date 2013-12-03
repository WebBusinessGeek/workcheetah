class NotificationsController < ApplicationController
  before_filter :user_signed_in?
  respond_to :js

  def index
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy unless @notification.nil?
  end
end