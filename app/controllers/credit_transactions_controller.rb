class CreditTransactionsController < ApplicationController
  def create
    @credit_package = CreditPackage.find(params[:credit_transaction][:credit_package_id])
    @credit_transaction = CreditTransaction.new(credit_transaction_params)
    @credit_transaction.account = current_account
    @credit_transaction.credit_package = @credit_package
    @pp = PaymentProfile.active.new(stripe_card_token: @credit_transaction.stripe_card_token, account: current_account)
    @pp.save

    if @credit_transaction.save
      @job_to_redirect_to = Job.find(session[:job_to_redirect_to_after_credit_transaction]) if session[:job_to_redirect_to_after_credit_transaction]
      notice_message = "#{ view_context.pluralize(@credit_transaction.quantity, "Credit")} where added to your account."
      if @job_to_redirect_to
        redirect_to my_jobs_path, notice: notice_message
        # redirect_to [@job_to_redirect_to, :job_applicants], notice: notice_message
      else
        redirect_to my_jobs_path, notice: notice_message
      end
    end
  end

  private

  def credit_transaction_params

    params.require(:credit_transaction).permit(:all)
  end
end