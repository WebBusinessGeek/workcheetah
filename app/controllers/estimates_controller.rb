class EstimatesController < ApplicationController
  before_filter :load_estimate, only: [:show, :propose, :accept, :reject, :negotiate, :edit, :update, :destroy]
  def index
    @estimates = current_user.resume.sent_estimates
  end

  def for_job
    @job = Job.find(params[:job_id])
    @estimates = @job.recieved_estimates.sent
    render 'index'
  end

  def recieved
    @recieved_estimates = Estimate.where(job_id: [current_account.job_ids]).sent
    render 'index'
  end

  def show
    authorize! :show, @estimate
    @commentable = @estimate
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @job = Job.find(params[:job_id])
    @estimate = current_user.resume.sent_estimates.build
    @estimate.estimate_items.build
  end

  def edit
    authorize! :edit, @estimate
    @job = @estimate.job
  end

  def create
    @estimate = current_user.resume.sent_estimates.build(estimate_params)

    if @estimate.save!
      if params[:commit] == "Send Estimate"
        @estimate.accept
        @estimate.send_proposal
        msg = "Estimate has been sent successfully"
      else
        msg = "Estimate has been saved successfully"
      end
      redirect_to estimates_path, notice: msg
    else
      render :new
    end
  end

  def update
    authorize! :update, @estimate
    if @estimate.update_attributes(estimate_params)
      if params[:commit] == "Send Estimate"
        @estimate.send_proposal
        msg = "Estimate sent."
      else
        msg = "Estimate updated."
      end
      redirect_to estimates_path, notice: msg
    end
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

  def propose
    @estimate.send_proposal
    redirect_to :back, notice: "Estimate has been sent."
  end

  def accept
    @estimate.hire!(params[:type])
    redirect_to :back, notice: "Estimate has been accepted"
  end

  def reject
    @estimate.reject
    redirect_to :back, notice: "Estimate has been rejected."
  end

  def negotiate
    @estimate.negotiate
    redirect_to my_jobs_path, notice: "Estimate has been sent back."
  end

  private
    def load_estimate
      @estimate = Estimate.find(params[:id])
    end

    def estimate_params
      params.require(:estimate).permit(:job_id, :due_date, :start_date, :terms, :notes, estimate_items_attributes: [:id, :task, :hours, :total, :_destroy])
    end
end
