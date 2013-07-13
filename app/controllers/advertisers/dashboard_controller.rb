class Advertisers::DashboardController < Advertisers::BaseController
  skip_before_filter :authorize_advertiser!, only: [:new_sign_up, :create_sign_up]

  respond_to :html, :js
  def home
  end

  def new_sign_up
    @signup = AdvertiserSignUp.new
  end

  def create_sign_up
    @signup = AdvertiserSignUp.new(params[:advertiser_sign_up])

    if @signup.save
      sign_in @signup.user, bypass: true
      flash[:notice] = "Successfully signed up"
      redirect_to new_advertisers_campaign_path
    else
      render action: :new_sign_up
    end
  end
end