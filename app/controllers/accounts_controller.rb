class AccountsController < ApplicationController
  def index
    @accounts = Account.scoped
  end

  def show
    @account = Account.find(params[:id])
  end
end