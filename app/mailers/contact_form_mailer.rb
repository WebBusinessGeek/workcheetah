class ContactFormMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def submit_contact_form(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: "support@workcheetah.com", subject: "Contact Form Submission")
  end
end