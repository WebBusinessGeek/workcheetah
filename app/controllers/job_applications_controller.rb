class JobApplicationsController < ApplicationController
  before_filter :load_job, except: [:index, :recieved]
  before_filter :authorize_user, except: [:index, :recieved, :show, :create, :new, :update, :apply_with_questionaire]

  def index
    if params[:job_id]
      @job = Job.unscoped.active.has_account.where(id: params[:job_id]).first
    end

    if @job
      if !user_signed_in? || (!current_user.resume and current_user.account != @job.account)
        return redirect_to new_resume_path, notice: "You have to have a resume to view that."
      end
      @job_applications = @job.job_applications
    else
      @job_applications = current_user.job_applications
    end
  end

  def recieved
    if current_user.account && (['freelancer', 'business'].include? current_user.role?)
      @job_applications = JobApplication.where(job_id: [current_user.account.job_ids]).order(:job_id)
    else
      redirect_to search_categories_path, notice: "You cannot access that page"
    end
  end

  def show
    @job_application = JobApplication.find(params[:id])
    @resume = @job_application.user.resume
    if @resume == current_user.resume
      redirect_to job_path(@job_application.job_id) and return
    end
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
        NotificationMailer.delay.new_job_application(@job_app)
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
    # @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    if @job_application.hire!(params[:type])
      message = "User hired"
    else
      message = "Failure to hire"
    end
    redirect_to [@job, :job_applications], notice: message
  end

  def reject
    # @job = Job.find(params[:job_id])
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
    if params[:job_id]
      @job = Job.unscoped.active.has_account.where(id: params[:job_id]).first
    else
      @job = JobApplication.find(params[:id]).job
    end
  end

  def job_application_params
    params.require(:job_application).permit(:note)
  end
end
