class ValidationRequestsController < ApplicationController
  def new
    verify_has_account
    @validation_request = ValidationRequest.new
  end

  def create
    verify_has_account
    @validation_request = ValidationRequest.new(validation_request_params, account: current_user.account)
    if @validation_request.save
      ValidationRequestMailer.new_validation_request(@validation_request).deliver
      redirect_to [:account], notice: "Your validation seal request has been submitted."
    end
  end

  private

  def validation_request_params
    params.require(:validation_request).permit(:name, :ein, :ssn, :industry, :length_of_business, :commission_only)
  end

  def verify_has_account
    redirect_to root_path, notice: "You need an account to access this page" if current_account.nil?
  end
end