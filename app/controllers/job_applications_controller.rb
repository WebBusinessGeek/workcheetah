class JobApplicationsController < ApplicationController
  before_filter :load_job
  before_filter :authorize_user, except: [:index, :show, :create, :new]

  def index
    if @job
      @job_applications = @job.job_applications
      # if can? :manage, @job

      # else
      #   redirect_to @job, alert: "Access denied."
      # end
    else
      @job_applications = current_user.job_applications
    end
  end

  def show
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @resume = @job_application.user.resume
    if can? :read, @job_application
      @job_application.status = "Company Interested"
      @job_application.save if @job_application.changed?
      render "resumes/show"
    else
      @job_application.status = "Viewed"
      @job_application.save if @job_application.changed?
      render "resumes/preview_resume"
    end
  end

  def reject
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @job_application.reject!
    redirect_to [@job, @job_application]
  end

  def new
    authenticate_user!

    if current_user.resume.nil?
      redirect_to new_resume_path, notice: "Before you can apply for a job, please create your resume"
    elsif current_user.job_applications.where(job_id: @job.id).any?
      redirect_to @job, notice: "You've already applied to this job."
    else
      @job_app = current_user.job_applications.create(job: @job, status: "Applicant Sent")
      NotificationMailer.new_job_application(@job_app).deliver
      redirect_to @job, notice: "Application sent! You'll hear back soon."
    end
  end

  def buy

    @job_application = @job.job_applications.find(params[:id])

    if current_user.account.has_payment_profile?
      if can? :read, @job_application
        redirect_to [@job_application.job, @job_application], notice: "You already have access to this job application. No need to buy it again."
      else
        @purchase_response = current_user.account.buy_applicant(@job_application)
        # if @purchase_response.failure_message.nil?
        if @purchase_response
          redirect_to [@job_application.job, @job_application], notice: "Access purchased"
        else
          redirect_to [@job_application.job, @job_application], error: "Something went wrong with the purcahse"
        end
      end
    else
      @payment_profile = current_user.account.payment_profiles.new
      render "create_payment_profile"
    end
  end

  private

  def authorize_user
    if @job
      unless can? :manage, @job
        redirect_to @job, notice: "You're not authorize to view that page."
      end
    end
  end

  def load_job
    @job = Job.find(params[:job_id]) if params[:job_id]
  end
end