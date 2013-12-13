class PaymentProfilesController < ApplicationController
  def new
    @payment_profile = current_user.account.payment_profiles.new
    @payment_profile.product = params[:product]
    session[:return_to] ||= request.referer
  end

  def create
    @payment_profile = current_user.account.payment_profiles.new(payment_profile_params)
    product = @payment_profile.product

    if @payment_profile.save
      if product == "seal"
        redirect_to [:add_seal, :account], notice: "Your billing information has been saved and you're ready to now verify your company."
      else
        if session[:return_to]
          redirect_to session.delete(:return_to)
        else
          redirect_to root_path
        end
      end
    end
  end

  def destroy
    @payment_profile = current_user.account.payment_profiles.find(params[:id])
    @payment_profile.delete
    redirect_to account_path
  end

  private

  def payment_profile_params
    params.require(:payment_profile).permit(:stripe_card_token, :product)
  end

  def buy_job_application(job_application_id)
    @job_application = JobApplication.find(job_application_id)
    # @job = @job_application.job
    @purchase_response = current_user.account.buy_applicant(@job_application)
    if @purchase_response.failure_message.nil?
      redirect_to [@job_application.job, @job_application], notice: "Recruit added."
    end
  end
end