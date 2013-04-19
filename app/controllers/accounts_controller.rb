class AccountsController < ApplicationController
  def index
    if current_user.admin?
      @accounts = Account.scoped
    else
      redirect_to root_path, notice: "Access denied"
    end
  end

  def show
    load_account
    # redirect_to root_path, notice: "Access denied" unless current_user.admin? || current_user.account == @account
    if params[:slug]
      @jobs = @account.jobs
      @portal = true
      render "jobs/index", layout: "portal"
    else
      render "show"
    end
  end

  def edit
    load_account
  end

  def customize
    load_account
  end

  def update
    load_account
    @account.assign_attributes(account_params)
    @account.save
    redirect_to account_path
  end

  def add_seal
    load_account
    if @account.safe_job_seal?
      redirect_to my_jobs_path, notice: "Your account already has the Safe Job seal."
    end
  end

  def remove_seal
    load_account
    @account.update_attribute(:safe_job_seal, false)
    redirect_to [:account]
  end

  def buy_seal
    load_account
    @response = @account.buy_seal
    # if @response.failure_message.nil?
    if @response
      redirect_to [:account], notice: "Congratulations! You have started the verification process. All of your jobs will have a temporary seal while we complete the verification process."
    else
      redirect_to [:add_seal, :account], notice: "Something went wrong while adding Safe Job seal."
    end
  end

  def suspend
    load_account
    @account.update_attribute(:active, false)
    @account.jobs.update_all(active: false)
    redirect_to accounts_path
  end

  private

  def load_account
    if params[:id].present?
      @account = Account.find(params[:id])
    elsif params[:slug].present?
      @account = Account.where(slug: params[:slug]).first!
    else
      @account = current_user.account
    end
  end

  def account_params
    params.require(:account).permit(:name, :slug, :logo)
  end
end