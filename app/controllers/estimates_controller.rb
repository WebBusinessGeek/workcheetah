class EstimatesController < ApplicationController
  before_filter :load_estimate, only: [:show, :edit, :update, :destroy]
  def index
    @estimates = current_user.resume.sent_estimates
  end

  def for_job
    @job = Job.find(params[:job_id])
    @estimates = @job.recieved_estimates.sent
    render 'index'
  end

  def show
  end

  def new
    @job = Job.find(params[:job_id])
    @estimate = current_user.resume.sent_estimates.build
    @estimate.estimate_items.build
  end

  def create
    @estimate = current_user.resume.sent_estimates.build(estimate_params)

    if @estimate.save!
      if params[:submit] == "Send Estimate"
        @estimate.send
        notice = "Estimate has been sent successfully"
      else
        notice = "Estimate has been saved successfully"
      end
      redirect_to @estimate.job, notice: notice
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  def buy_credits
    @account = current_user.account
    if params[:selection]
      @to_buy = Estimate::PRICE.send(params[:selection])
      @response = @account.buy_credits('estimate', @to_buy)
    end
    logger.debug @response
    redirect_to request.referer
  end

  private
    def load_estimate
      @estimate = Estimate.find(params[:id])
    end

    def estimate_params
      params.require(:estimate).permit(:job_id, :due_date, :terms, :notes, estimate_items_attributes: [:title, :hours, :total])
    end
end
