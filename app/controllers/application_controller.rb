class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_account
    @account ||= current_user.account
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| Rails.logger.info(exception.to_s); render_error 500, exception; }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception|  Rails.logger.info(exception.to_s); render_error 404, exception; }
  end

  def current_location
    @visitors_ip ||= Rails.env.development? ? "71.197.119.115" : request.remote_ip
    @current_location ||= Geocoder.search(@visitors_ip).first
  end

  def human_readable_current_location
    @current_location = current_location
    if @current_location
      @location ||= [@current_location.city, @current_location.state].map{ |x| x if x.present? }.join(", ")
    else
      @location ||= ""
    end

    @location
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
