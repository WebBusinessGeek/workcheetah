class EmailSubscriptionsController < ApplicationController
  def create
    @email_subscription = EmailSubscription.new(email_subscription_params)
    @email_subscription.save
    redirect_to @email_subscription.return_url + "&subscribed=true"
  end

  private

  def email_subscription_params
    params.require(:email_subscription).permit(:query, :location, :email, :return_url)
  end

end