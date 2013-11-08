class ShiftsController < ApplicationController
  def index
    @shifts = Shift.all
    @invitational = Invitational.new
    @staffers = current_user.staffed_users.includes(:resume, :account)
  end

  def show
    @shift = Shift.find(params[:id])
  end

  def new
    @shift = Shift.new
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def create
    @shift = Shift.new(shift_params)

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render json: @shift, status: :created, location: @shift }
      else
        format.html { render action: "new" }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @shift = Shift.find(params[:id])

    respond_to do |format|
      if @shift.update_attributes(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
  end

  def invite
    @invitational = Invitational.new(
      email: params[:invitational][:email],
      name: params[:invitational][:name],
      type: "Staff",
      type_id: current_user.id
    )
    @invitational.save
    render 'shifts/invite'
  end

  def calender
    @shifts = current_user.account.created_shifts.collect(&:to_calender_json)
    logger.debug @shifts.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def shift_params
      params.require(:shift).permit(:creator_id, :employee_id, :end_hour, :schedule_date, :shift_hours, :start_hour)
    end
end
