class JobApplicationsController < ApplicationController
  before_filter :load_job
  before_filter :authorize_user, except: [:index, :show, :create, :new, :update, :apply_with_questionaire]

  def index
    if !user_signed_in? || (!current_user.resume and current_user.account != @job.account)
      return redirect_to new_resume_path, notice: "You have to have a resume to view that."
    end

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
    if ['freelancer', 'business'].include? current_user.role?
      @available_jobs = Job.find(current_user.account.job_ids - @resume.invites.map(&:job_id))
    end
    # if can? :read, @job_application
    #   @job_application.status = "Company Interested"
    #   @job_application.save if @job_application.changed?
    #   render "resumes/show"
    # else
    #   @job_application.status = "Viewed" if @job_application.status == "Application Sent"
    #   @job_application.save if @job_application.changed?
    #   render "resumes/preview_resume"
    # end
    render "resumes/preview_resume"
  end

  def new
    authenticate_user!

    if current_user.resume.nil?
      redirect_to new_resume_path, notice: "Before you can apply for a job, please create your resume"
    elsif current_user.job_applications.where(job_id: @job.id).any?
      redirect_to @job, notice: "You've already applied for this job."
    else
      @job_app = current_user.job_applications.build(job: @job, status: "Application Sent")
      if can? :create, @job_app
        @job_app.save
        current_user.activities.create(message: "Applied for a job", job_id: @job.id)
        NotificationMailer.new_job_application(@job_app).deliver
        redirect_to @job, notice: "Application sent! You'll hear back soon."
      else
        flash[:error] = "This is an invite only job - you cannot apply unless you have been invited to do so by the job poster."
        redirect_to @job
      end
    end
  end

  def apply_with_questionaire
    params[:job][:answers_attributes].each do |a|
      Answer.create!(
        question_id: a.first,
        user_id: a.last[:user_id],
        text: a.last[:text]
      )
    end
    redirect_to new_job_job_application_path(@job)
  end

  def update
    @job_application = JobApplication.find(params[:id])
    @job_application.update_attributes(job_application_params)
  end

  def hire
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    if @job_application.hire!(params[:type])
      message = "User hired"
    else
      message = "Failure to hire"
    end
    redirect_to [@job, :job_applications], notice: message
  end

  def reject
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @job_application.reject!
    redirect_to [@job, :job_applications]
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

  def job_application_params
    params.require(:job_application).permit(:note)
  end
end
