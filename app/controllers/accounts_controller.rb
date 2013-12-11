class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_account, except: [:index, :new]

  respond_to :html, :js

  def index
    if current_user.admin?
      @accounts = Account.scoped
    else
      redirect_to root_path, notice: "Access denied"
    end
  end

  def new
    @account = current_user.build_account
  end

  def show
    @user = current_user
    if params[:part] == "bank_account"
      @part = :bank_account
    elsif params[:part] == "login"
      @part = :login
    elsif params[:part] == "company"
      @part = :company
    else
      @part = :show
    end
    logger.debug @part
  end

  def edit
  end

  def customize
  end

  def update
    @account.assign_attributes(account_params)
    @account.save
    redirect_to account_path
  end

  def add_seal
    if @account.safe_job_seal?
      redirect_to my_jobs_path, notice: "Your account already has the Safe Job seal."
    end
  end

  def remove_seal
    @account.update_attribute(:safe_job_seal, false)
    redirect_to [:account]
  end

  def buy_seal
    @response = @account.buy_seal
    # if @response.failure_message.nil?
    if @response
      NotificationMailer.seal_purchase(current_user).deliver
      redirect_to [:new, :validation_request], notice: "Your card was charged $ #{PaymentProfile::SAFE_SEAL_PRICE_IN_DOLLARS}. Your next step is to complete the Validation Seal Request form below."
    else
      redirect_to [:add_seal, :account], notice: "Something went wrong while adding Safe Job seal."
    end
  end

  def suspend
    @account.update_attribute(:active, false)
    @account.jobs.update_all(active: false)
    redirect_to accounts_path
  end

  def recruits
    @accessible_job_applications = @account.job_applications.includes(:job, user: :resume)
  end

  private

  def load_account
    if params[:id].present?
      @account = Account.find(params[:id])
    elsif params[:slug].present?
      @account = Account.where(slug: params[:slug]).first!
    elsif current_user
      @account = current_user.account
      if @account.nil?
        @account = current_user.build_account
      end
    end
  end

  def account_params
    params.require(:account).permit(:name, :slug, :logo, :role)
  end
end