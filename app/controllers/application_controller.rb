class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :get_tweet

  def get_tweet
    # if user_signed_in? and current_user.account.present?
    if user_signed_in?
      if @current_user.role? == 'Freelancer'
        current_user = Freelancer.find_by_id(@current_user.id)
        @tweet = Tweet.where(for_accounts: true).order("id DESC").first if current_user.account.present?
      elsif @current_user.role? == 'Business'
        current_user = Business.find_by_id(@current_user.id)
        @tweet = Tweet.where(for_accounts: true).order("id DESC").first if current_user.account.present?
      elsif @current_user.role? == 'Employee'
        current_user = Employee.find_by_id(@current_user.id)
        @tweet = Tweet.where(for_resumes: true).order("id DESC").first
      else
        @tweet = Tweet.where(for_public: true).order("id DESC").first
      end
    # elsif user_signed_in? and current_user.resume.present?
    #   @tweet = Tweet.where(for_resumes: true).order("id DESC").first
    # else
    #   @tweet = Tweet.where(for_public: true).order("id DESC").first
    end
  end

  def current_account
    @account ||= current_user.account
  end

  def current_target_params
    if user_signed_in?
      @current_target_params ||= current_user.target_params
    else
      @current_target_params = "all"
    end
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

  def authorize_admin!
    return redirect_to root_path, notice: "You're not authorized to view this page." unless user_signed_in? && current_user.admin?
  end

  def authorize_moderator!
    return redirect_to root_path, notice: "You're not authorized to view this page." unless user_signed_in? && current_user.moderator?
  end

  def authorize_advertiser!
    return redirect_to root_path, notice: "You're not authorized to view this page." unless user_signed_in? && current_user.advertiser?
  end
end
