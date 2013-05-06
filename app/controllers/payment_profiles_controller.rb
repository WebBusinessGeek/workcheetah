class PaymentProfilesController < ApplicationController
  def new
    @payment_profile = current_user.account.payment_profiles.new
    @payment_profile.product = params[:product]
  end

  def create
    @payment_profile = current_user.account.payment_profiles.new(payment_profile_params)
    job_application_id = @payment_profile.first_job_applicant_to_buy
    product = @payment_profile.product


    if @payment_profile.save
      if job_application_id
        buy_job_application(@payment_profile.first_job_applicant_to_buy)
      elsif product == "seal"
        redirect_to [:add_seal, :account], notice: "Your billing information has been saved and you're ready to now verify your company."
      else
        redirect_to account_path
      end

    else
      render "job_applications/create_payment_profile"
    end
  end

  def destroy
    @payment_profile = current_user.account.payment_profiles.find(params[:id])
    @payment_profile.delete
    redirect_to account_path
  end

  private

  def payment_profile_params
    params.require(:payment_profile).permit(:stripe_card_token, :first_job_applicant_to_buy, :product)
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