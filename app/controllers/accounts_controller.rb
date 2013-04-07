class AccountsController < ApplicationController
  def index
    @accounts = Account.scoped
  end

  def show
    load_account
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