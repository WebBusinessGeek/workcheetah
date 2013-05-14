class JobsController < ApplicationController
  before_filter :hide_some_jobs_from_companies, only: [ :index ]

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
      @jobs = Job.text_search(@query, @location).order("created_at DESC")
    else
      @jobs = Job.scoped.order('created_at desc')
    end

    # if !@jobs.any? # if no jobs
    #   @jobs = Job.scoped.order('created_at DESC')
    #   flash[:notice] = "There were no jobs near you or in your state, so here are all jobs."
    # end

    @articles = Article.order(:created_at).limit(10) if @jobs.empty?

    # if @jobs.empty? && @query.present?
    #   @session_variable = (@query.parameterize.gsub('-','_') + "_jobs_count").to_sym
    #   @jobs_count = session[@session_variable] ||= 28 + Random.rand(63)
    # end

    respond_to do |format|
      format.html do
        if @jobs.any?
          render "index"
        else
          @email_subscription = EmailSubscription.new

          render "getting_faster"
        end
      end
      format.json { render json: @jobs }
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

    raise CanCan::AccessDenied if user_signed_in? && current_user.account && cannot?(:show, @job)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new

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
    raise CanCan::AccessDenied if user_signed_in? && current_user.account && cannot?(:edit, @job)
  end

  # POST /jobs
  # POST /jobs.json
  def create
    # raise params.inspect

    @job = Job.new(job_params)
    @job.email_for_claim = params[:job][:email_for_claim]

    if current_user
      if current_user.moderator?
        @job.account = nil
      elsif !current_user.moderator?
        if current_user.account
          @job.account = current_user.account
        else
          @job.account.users << current_user
        end
      end
    end

    # if user_signed_in? && current_user.moderator?
    #   @job.account = nil
    # elsif user_signed_in? && !current_user.moderator?
    #   if current_user.account
    #     @job.account = current_user.account
    #   else
    #     @job.account.users << current_user
    #   end
    # end

    respond_to do |format|
      if @job.save
        if current_user
          if current_user.moderator?
            NotificationMailer.new_claimable_job(@job).deliver
          end
        else
          NotificationMailer.new_job(@job).deliver
        end

        sign_in @job.account.users.first unless user_signed_in?

        if current_user.moderator?
          format.html { redirect_to :back, notice: "Job created successfully." }
        else
          format.html { redirect_to (@job.account.safe_job_seal? ? @job : [:add_seal, :account]), notice: 'Job was successfully created.' }
          format.json { render json: @job, status: :created, location: @job }
        end
      else
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

    respond_to do |format|
      if @job.update_attributes(job_params)

        sign_in @job.account.users.first unless user_signed_in?
        
        format.html { redirect_to (@job.account.safe_job_seal? ? @job : [:add_seal, :account]), notice: 'Job was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
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

  def quick_apply
    # raise params.inspect

    return redirect_to new_resume_path, notice: "Please build a resume to apply to jobs." if !user_signed_in?

    job_ids = params[:job_ids]
    return redirect_to :back, notice: "Please check some jobs you want to quick apply for." if job_ids.nil?

    job_ids.each do |job_id|
      if JobApplication.where(user_id: current_user.id, job_id: job_id).empty? and Job.find(job_id).quick_applicable?
        JobApplication.create(user_id: current_user.id, job_id: job_id, status: "Application Sent")
      end
    end

    redirect_to root_path, notice: "Successfully applied for #{view_context.pluralize job_ids.count, "job"}."
  end

  def hide_some_jobs_from_companies
    raise CanCan::AccessDenied if user_signed_in? && current_user.account
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :category_id, :email_for_claim, :about_company, :address, account_attributes: [ :name, :website, :phone, :slug, users_attributes: [ :email, :password, :password_confirmation, :terms_of_service ] ])
  end
end
