class ValidationRequestMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def new_validation_request(validation_request)
    @validation_request = validation_request
    mail(:to => "support@workcheetah.com", :subject => "New Validation Seal Request")
  end
end
