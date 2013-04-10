class DashboardsController < ApplicationController
  layout "home"
  def home
    @articles = Article.order('created_at desc').limit(10)
    @visitors_ip = Rails.env.development? ? "71.197.119.115" : request.remote_ip

    @current_location = Geocoder.search(@visitors_ip).first
    if @current_location
      @current_location_clean = [@current_location.city, @current_location.state].map{ |x| x if x.present? }.join(", ")
    else
      @current_location_clean = ""
    end
  end
end