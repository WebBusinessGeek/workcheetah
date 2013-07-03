class Advertisers::AccountsController < Advertisers::BaseController
  before_filter :load_advertiser_account, only: [:show, :edit, :update]
  skip_before_filter :authorize_advertiser!, only: [:index]

  respond_to :html, :js

  def index
    if current_user.admin?
      @accounts = AdvertiserAccount.scoped
    else
      redirect_to root_path, notice: "Access denied"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private 
    def load_advertiser_account
      @account = AdvertiserAccount.find(params[:id])
    end
end