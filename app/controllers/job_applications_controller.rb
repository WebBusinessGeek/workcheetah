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
    if can? :read, @job_application
      @job_application.status = "Company Interested"
      @job_application.save if @job_application.changed?
      render "resumes/show"
    else
      @job_application.status = "Viewed" if @job_application.status == "Application Sent"
      @job_application.save if @job_application.changed?
      render "resumes/preview_resume"
    end
  end

  def reject
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.find(params[:id])
    @job_application.reject!
    redirect_to [@job, :job_applications]
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

  def buy
    @job_application = @job.job_applications.find(params[:id])

    if can? :read, @job_application
      redirect_to [@job_application.job, @job_application], notice: "You already have access to this job application. No need to save it again."
    else
      @purchase_response = current_user.account.buy_applicant(@job_application) # currently returns true in any case to make the purchase free
      if @purchase_response
        redirect_to [@job_application.job, @job_application], notice: "Recruit added."
      else
        redirect_to [@job_application.job, @job_application], error: "Something went wrong with the purcahse"
      end
    end

    # Once the application purchase is not free anymore, uncomment below code

    # if current_user.account.has_payment_profile?
    #   if can? :read, @job_application
    #     redirect_to [@job_application.job, @job_application], notice: "You already have access to this job application. No need to buy it again."
    #   else
    #     @purchase_response = current_user.account.buy_applicant(@job_application)
    #     # if @purchase_response.failure_message.nil?
    #     if @purchase_response
    #       redirect_to [@job_application.job, @job_application], notice: "Recruit added."
    #     else
    #       redirect_to [@job_application.job, @job_application], error: "Something went wrong with the purcahse"
    #     end
    #   end
    # else
    #   @payment_profile = current_user.account.payment_profiles.new
    #   render "create_payment_profile"
    # end
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