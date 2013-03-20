class ProfilesController < ApplicationController
  # before_filter :authenticate_user!

  def new
    @profile = Profile.new
    @profile.addresses.build
    @profile.schools.build
    @profile.references.build
    @profile.experiences.build
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to profile_path(@profile), notice: "Profile created successfully"
    else
      render "new"
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path(@profile), notice: "Resume updated successfully"
    else
      render "edit"
    end
  end

  private

  def profile_params
    params.require(:profile).permit( :name, :phone, :email, :website,
      :twitter, :status, :growth_importance, :distance_importance,
      :freedom_importance, :pay_importance,
      addresses_attributes: [ :address_1, :address_2, :city, :state, :zip ],
      experiences_attributes: [ :company_name, :job_title, :from, :till, :highlights ],
      schools_attributes: [ :name, :degree_type, :degree_name, :from, :till, :highlights],
      references_attributes: [ :name, :job_title, :company, :phone, :email, :notes, :reference_type ] )
  end
end