class ValidationRequestsController < ApplicationController
  def new
    verify_has_account
    @validation_request = ValidationRequest.new
  end

  def create
    verify_has_account
    @validation_request = ValidationRequest.new(validation_request_params)
    @validation_request.account = current_user.account

    @validation_request.build_address(params[:validation_request][:address])
    if @validation_request.save
      ValidationRequestMailer.delay.new_validation_request(@validation_request).deliver
      ValidationRequestMailer.delay.validation_receipt(@validation_request, current_user).deliver
      redirect_to [:account], notice: "Thank you for your application. We have provided you with a temporary seal until we conclude review of your application."
    else
      render action: :new
    end
  end

private

  def validation_request_params
    params.require(:validation_request).permit(:address_attributes, :commission_only, :contact_email, :contact_person, :contact_phone, :ein, :independent_distributorship_opportunity, :industry, :length_of_business, :name, :profit, :ssn)
  end

  def verify_has_account
    redirect_to root_path, notice: "You need an account to access this page" if current_account.nil?
  end
end