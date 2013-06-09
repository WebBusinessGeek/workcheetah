class ValidationRequestMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def new_validation_request(validation_request)
    @validation_request = validation_request
    mail(:to => "sealrequests@workcheetah.com", :subject => "New Validation Seal Request")
  end

  def validation_receipt(validation_request, user)
  	@validation_request = validation_request
    mail(:to => user.email, :subject => "New Validation Seal Request")
  end
end
