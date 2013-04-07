class ResumesController < ApplicationController
  # before_filter :authenticate_user!

  def new
    @user = user_signed_in? ? current_user : User.new
    @resume = @user.build_resume
    @resume.addresses.build
    @resume.schools.build
    @resume.references.build
    @resume.experiences.build
  end

  def create
    @resume = current_user.build_resume(resume_params)
    if @resume.save
      redirect_to resume_path(@resume), notice: "Profile created successfully"
    else
      render "new"
    end
  end

  def show
    load_resume
  end

  def edit
    load_resume
    @resume.addresses.build unless @resume.addresses.any?
    @resume.schools.build unless @resume.schools.any?
    @resume.references.build unless @resume.references.any?
    @resume.experiences.build unless @resume.experiences.any?
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
    redirect_to @resume
  end

  private

  def resume_params
    params.require(:resume).permit( :name, :phone, :email, :website,
      :twitter, :status, :growth_importance, :distance_importance,
      :freedom_importance, :pay_importance,
      addresses_attributes: [ :id, :address_1, :address_2, :city, :state, :zip, :_destroy ],
      experiences_attributes: [ :id, :company_name, :job_title, :from, :till, :highlights, :_destroy ],
      schools_attributes: [ :id, :name, :degree_type, :degree_name, :from, :till, :highlights, :_destroy],
      references_attributes: [ :id, :name, :job_title, :company, :phone, :email, :notes, :reference_type, :_destroy ] )
  end

  def load_resume
    @resume = Resume.find(params[:id])
  end
end