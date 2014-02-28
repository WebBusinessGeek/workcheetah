class JobsController < ApplicationController
  before_filter :hide_some_jobs_from_companies, only: [ :index ]
  before_filter :check_for_account, only: [:my]

  #TODO: Tidy up controller code

  # GET /jobs
  # GET /jobs.json
  def index
    @query = params[:search]
    if params[:location]
      @location = params[:location]
    else
      @current_location = current_location
      @location ||= human_readable_current_location
    end

    if @query.present? || @location.present?
      @jobs = Job.text_search(@query, @location).order("created_at DESC").page(params[:page]).per_page(8)
    else
      @jobs = Job.scoped.order('created_at desc').page(params[:page]).per_page(8)
    end

    if !@jobs.any? # if no jobs
      @jobs = Job.scoped.order('created_at DESC').page(params[:page]).per_page(8)
      flash[:notice] = "There were no jobs near you or in your state, so here are all jobs."
    end

    @articles = Article.order(:created_at).limit(10) if @jobs.empty?

    if @jobs.empty? && @query.present?
      #TODO: Possible security whole here, fix symbol conversion from unsafe string
      @session_variable = (@query.parameterize.gsub('-','_') + "_jobs_count").to_sym
      @jobs_count = session[@session_variable] ||= 28 + Random.rand(63)
    end

    respond_to do |format|
      format.html do
        if @jobs.any?
          render "index"
        else
          @email_subscription = EmailSubscription.new

          render "getting_faster"
        end
      end
      format.js { render "index" }
    end
  end

  def my
    authenticate_user!
    @jobs = current_user.account.jobs

    respond_to do |format|
      format.html
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    # raise CanCan::AccessDenied if user_signed_in? && current_user.account && cannot?(:show, @job)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new
    @job.questions.build

    if user_signed_in?
      unless current_user.account
        @account = @job.build_account
      end
    else
      @account = @job.build_account
      @account.users.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @job.questions.build unless @job.questions.count > 1
    raise CanCan::AccessDenied if user_signed_in? && current_user.account && cannot?(:edit, @job)
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.email_for_claim = params[:job][:email_for_claim]

    if current_user
      if current_user.moderator?
        @job.account = nil
      elsif !current_user.moderator?
        if current_user.account
          logger.debug "current user has account and assigning to job"
          @job.account = current_user.account
        else
          @job.account.users << current_user
        end
      end
    end

    respond_to do |format|
      if @job.save
        if current_user
          if current_user.moderator?
            NotificationMailer.new_claimable_job(@job).deliver
          end
        else
          NotificationMailer.new_job(@job).deliver
        end

        @job.account.owner.update_attribute :role, "business" unless user_signed_in?
        sign_in @job.account.owner unless user_signed_in?

        if current_user.moderator?
          format.html { redirect_to :back, notice: "Job created successfully." }
        else
          format.html { redirect_to root_path, notice: 'Job was successfully created.' }
          format.json { render json: @job, status: :created, location: @job }
        end
      else
        logger.debug @job.errors.inspect
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.unscoped.where(id: params[:id], active: true).first
    raise CanCan::AccessDenied if user_signed_in? && current_user.account && cannot?(:update, @job)
    begin respond_to do |format|
        if @job.update_attributes(job_params)

          sign_in @job.account.users.first unless user_signed_in?

          format.html { redirect_to root_path, notice: 'Job was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      @job.errors.add :questions, "Only 5 questions can be created."
      render 'edit'
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    raise CanCan::AccessDenied if user_signed_in? && current_user.account && cannot?(:destroy, @job)
    @job.update_attribute(:active, false)

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  def flag
    @job = Job.find(params[:id])
    JobMailer.job_flagged(@job, request.remote_ip, (user_signed_in? ? current_user : nil)).deliver
    redirect_to request.referer, notice: "The job has been flagged. We'll take a look into this ASAP."
  end

  def claim
    @job = Job.unscoped.where(id: params[:id], active: true, account_id: nil).first
    return redirect_to root_path, notice: "That job has been claimed already or doesn't exist." if !@job

    if user_signed_in?
      unless current_user.account
        @account = @job.build_account
      end
    else
      @account = @job.build_account
      @account.users.build
    end

    render action: "new"
  end

# TODO: up for future deletion
  def quick_apply
    return redirect_to new_resume_path, notice: "Please Build Work Profile to apply to jobs." if !user_signed_in?

    job_ids = params[:job_ids]
    return redirect_to :back, notice: "Please check some jobs you want to quick apply for." if job_ids.nil?

    job_ids.each do |job_id|
      if JobApplication.where(user_id: current_user.id, job_id: job_id).empty? and Job.find(job_id).quick_applicable?
        JobApplication.create(user_id: current_user.id, job_id: job_id, status: "Application Sent")
      end
    end

    redirect_to root_path, notice: "Successfully applied for #{view_context.pluralize job_ids.count, "job"}."
  end

# Maybe move these to their own invites_controller
  def invite_job_seekers
    @job = Job.find(params[:job])
    @resume = Resume.find(params[:resume_id])

    raise CanCan::AccessDenied if @job.account_id != current_user.account.id

    Invite.create(resume_id: @resume.id, job_id: @job.id)
    @job.notifications.create(body: "You have been invited to a job.", user_id: @resume.user.id)
    @job.account.decrement_credit('invite')

    NotificationMailer.new_job_invite(@job, [@resume]).deliver

    redirect_to :back, notice: "Job applicant invited."
  end

  def buy_invites
    @account = current_user.account
    @to_buy = Invite::PRICE.send(params[:selection])
    @response = @account.buy_credits('invite', @to_buy)
    logger.debug @response
    redirect_to request.referer
  end

  def hide_some_jobs_from_companies
    raise CanCan::AccessDenied if user_signed_in? && ['Business', 'Freelancer'].include?(current_user.role?)
  end

  private

  def job_params
    params.require(:job).permit(:merit_requested, :yearly_compensation, :title, :invite_only, :description, :category_id, :category2_id, :category3_id,
                                :email_for_claim, :about_company, :address, :quick_applicable, :job_type, skill_ids: [],
                                questions_attributes: [:text, :_destroy ],
                                account_attributes: [ :name, :website, :phone, :slug, :role, :business_type, users_attributes: [ :email, :password, :password_confirmation, :terms_of_service ] ])
  end
end
