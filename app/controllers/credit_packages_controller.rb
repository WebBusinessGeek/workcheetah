class CreditPackagesController < ApplicationController
  def index
    @credit_packages = CreditPackage.scoped
  end

  def show
    @credit_package = CreditPackage.find(params[:id])
    @credit_transaction = CreditTransaction.new( credit_package: @credit_package)
    @credit_transaction.build_payment_profile
  end

end