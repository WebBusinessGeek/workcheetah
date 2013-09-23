class Advertisers::PaymentProfilesController < Advertisers::BaseController
  def new
    @payment_profile = current_user.advertiser_account.payment_profiles.new
  end

  def create
    @payment_profile = current_user.advertiser_account.payment_profiles.new(payment_profile_params)

    if @payment_profile.save
      redirect_to edit_advertisers_account_path, "Billing Info added successfully."
    else
      render action: :new
    end
  end

  def destroy
    @payment_profile = current_user.advertiser_account.payment_profiles.find(params[:id])
    @payment_profile.delete
    redirect_to edit_advertisers_account_path
  end

  private

  def payment_profile_params
    params.require(:payment_profile).permit(:stripe_card_token)
  end
end