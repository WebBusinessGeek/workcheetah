class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_account
    @account ||= current_user.account
  end
end
