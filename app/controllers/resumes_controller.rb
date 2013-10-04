class ResumesController < ApplicationController
  # before_filter :authenticate_user!

  def new
    @resume = Resume.new
    if user_signed_in?
      @resume.user = current_user
    else
      @resume.build_user
    end

    @resume.addresses.build
    @resume.schools.build
    @resume.references.build
    @resume.experiences.build
  end

  def create
    if current_user
      if current_user.moderator?
        @resume = Resume.new(resume_params)
      elsif !current_user.moderator?
        @resume = current_user.build_resume(resume_params)
      end
    else
      @resume = Resume.new(resume_params)
    end

    if @resume.save
      if current_user
        if current_user.moderator?
          NotificationMailer.new_claimable_resume(@resume).deliver
          redirect_to :back, notice: "Claimable resume created successfully."
        else
          redirect_to resume_path(@resume), notice: "Resume created successfully."
        end
      else
        @resume.user.update_attribute(:role, params[:resume][:resume_type])
        if ['freelancer', 'business'].include? @resume.resume_type
          a = Account.create name: @resume.name, business_type: @resume.resume_type
          a.users << @resume.user
        end

        sign_in @resume.user unless user_signed_in?
        redirect_to resume_path(@resume), notice: "Resume created successfully."
      end
    else
      render "new"
    end
  end

  def show
    @resume = Resume
      .includes(:user, :addresses, :experiences, :schools, :category1, :category2, :category3, references: [:confirmation])
      .where(id: params[:id]).first
    if ['freelancer', 'business'].include? current_user.role?
      @available_jobs = Job.find(current_user.account.job_ids - @resume.invites.map(&:job_id))
    end
    render 'resumes/preview_resume' unless user_signed_in? && (@resume.user == current_user || current_user.admin?)
  end

  def edit
    load_resume
  end

  def update
    load_resume
    @resume.assign_attributes(resume_params)
    if @resume.save
      redirect_to resume_path(@resume), notice: "Resume updated successfully"
    else
      render "edit"
    end
  end

  def add_video
    load_resume
    @uploader = @resume.video
    @uploader.success_action_redirect = update_video_resume_url(@resume)
  end

  def update_video
    load_resume
    @resume.key = params[:key]
    @resume.save
    @resume.enqueue_video
    redirect_to @resume
  end

  def claim
    @resume = Resume.find(params[:id])

    if user_signed_in?
      @resume.user = current_user
    else
      @resume.build_user
    end

    render action: "new"
  end

  def search
    @search = Resume.includes(:user, :skills, :schools).search(params[:q])
    @resumes = @search.result(:distinct => true).ranked.limit(20)
  end

  private

  def resume_params
    params.require(:resume).permit( :name, :phone, :email, :email_for_claim, :website,
      :twitter, :status, :growth_importance, :distance_importance,
      :category1_id, :category2_id, :category3_id, :resume_type, :current_employer,
      :freedom_importance, :pay_importance, :private, skill_ids: [],
      addresses_attributes: [ :id, :address_1, :address_2, :city, :state, :zip, :_destroy ],
      experiences_attributes: [ :id, :company_name, :job_title, :from, :till, :highlights, :_destroy ],
      schools_attributes: [ :id, :name, :degree_type, :degree_name, :from, :till, :highlights, :_destroy, :highest_merit, :course_of_study, :completion_year],
      references_attributes: [ :id, :name, :job_title, :company, :phone, :email, :notes, :reference_type, :_destroy ],
      user_attributes: [ :email, :password, :password_confirmation, :terms_of_service ] )
  end

  def load_resume
    @resume = Resume.find(params[:id])
  end
end