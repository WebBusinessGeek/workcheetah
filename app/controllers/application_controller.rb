class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_account
    @account ||= current_user.account
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception; raise exception; }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception; raise exception; }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

  def authorize_admin_user!
    redirect_to root_path, notice: "You're not authorized to view this page." unless user_signed_in? && current_user.admin?
  end
end
