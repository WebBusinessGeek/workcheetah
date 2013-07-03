class Advertisers::DashboardController < Advertisers::BaseController
  skip_before_filter :authorize_advertiser!, only: [:sign_up]
  
  respond_to :html, :js
  def home
  end

  def sign_up
  	resource = User.new(advertiser: true)
    respond_with resource
  end
end