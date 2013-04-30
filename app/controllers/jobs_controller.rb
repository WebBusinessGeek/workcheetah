class JobsController < ApplicationController
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
      @jobs = Job.text_search(@query, @location)
    else
      @jobs = Job.scoped.order('created_at desc')
    end

    if !@jobs.any? # if no jobs
      @jobs = Job.scoped.order('created_at DESC')
      flash[:notice] = "There were no jobs near you or in your state, so here are all jobs."
    end

    @articles = Article.order(:created_at).limit(10) if @jobs.empty?

    if @jobs.empty? && @query.present?
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
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    if user_signed_in?
      if current_user.account
        @job.account = current_user.account
      else
        @job.account.users << current_user
      end
    end

    respond_to do |format|
      if @job.save
        NotificationMailer.new_job(@job).deliver
        sign_in @job.account.users.first unless user_signed_in?
        format.html { redirect_to (@job.account.safe_job_seal? ? @job : [:add_seal, :account]), notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
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

  private

  def job_params
    params.require(:job).permit(:title, :description, :category_id, :about_company, :address, account_attributes: [ :name, :website, :phone, :slug, users_attributes: [ :email, :password, :password_confirmation ] ])
  end
end
