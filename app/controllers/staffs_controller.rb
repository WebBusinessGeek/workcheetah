class StaffsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js
  def index
    @staffed_users = current_user.staffed_users
  end

  def show
    @contact = User.find(params[:id])
    respond_with @contact
  end

  def contacts
    @clients = current_user.clients
    @staffed_users = current_user.staffed_users
    @contacts = @clients + @staffed_users
  end

  def remove
  end

  def new
    @staff = Staff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @staff }
    end
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])

    respond_to do |format|
      if @staff.update_attributes(staff_params)
        format.html { redirect_to staffing_path, notice: 'Staffer was successfully updated.' }
        format.json { render json: @staff, status: :created, location: @staff }
      else
        format.html { render action: "new" }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render json: @staff, status: :created, location: @staff }
      else
        format.html { render action: "new" }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to staffs_url }
      format.json { head :no_content }
    end
  end

  private
    def staff_params
      params.require(:staff).permit(:client_id, :staffer_id, :rate)
    end
end
