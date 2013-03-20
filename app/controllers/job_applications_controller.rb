class JobApplicationsController < ApplicationController
  def index
    @job = Job.find(params[:job_id])
    if can? :manage, @job
      @job_applications = @job.job_applications
    else
      redirect_to @job, alert: "Access denied."
    end
  end

  def new
    authenticate_user!
    @job = Job.find(params[:job_id])

    if current_user.job_applications.where(job_id: @job.id).any?
      redirect_to @job, notice: "You've already applied to this job."
    else
      current_user.job_applications.create(job: @job)
      redirect_to @job, notice: "Application sent! You'll hear back soon."
    end
  end

  def buy
    @job = Job.find(params[:job_id])
    if current_user.account.has_credits?
      @job_application = @job.job_applications.find(params[:id])
      @job_application.applicant_accesses.create(account: current_user.account)
      redirect_to @job_application
    else
      session[:job_to_redirect_to_after_credit_transaction] = @job.id
      redirect_to credit_packages_path, notice: "Looks like you don't have any credits yet. Please buy some."
    end

  end
end