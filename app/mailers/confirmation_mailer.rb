class ConfirmationMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def reference_request(confirmation)
    @confirmation = confirmation
    mail to: @confirmation.email, subject: "Confirmation Request from #{@name}"
  end
end
