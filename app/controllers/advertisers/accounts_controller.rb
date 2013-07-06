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

  def new
    @account = current_user.build_advertiser_account
  end

  def create
    @account = current_user.build_advertiser_account(account_params)
    if @account.save!
      redirect_to advertisers_advertisers_path, notice: "Account Successfully created."
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    @account.assign_attributes(account_params)
    if @account.save!
      redirect_to advertisers_advertisers_path, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private 
    def load_advertiser_account
      @account = AdvertiserAccount.find(params[:id])
    end

    def account_params
      params.require(:advertiser_account).permit(:company, :website, :phone)
    end
end