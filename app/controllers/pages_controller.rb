class PagesController < ApplicationController
  def contact
    if request.post?
      name = params[:name]
      email = params[:email]
      message = params[:message]
      ContactFormMailer.submit_contact_form(name, email, message).deliver
      @sent_email = true
    end
  end
end