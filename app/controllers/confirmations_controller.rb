class ConfirmationsController < ApplicationController
  def show
    @confirmation = Confirmation.find_by_confirmation_token(params[:confirmation_token])
    if @confirmation
      sign_in @confirmation.confirmed_by, bypass: true
      flash[:notice] = "Successfully signed up, please consider confirming requested references"
    else
      flash[:notice] = "Confirmation link invalid"
    end
    redirect_to root_path
  end
end