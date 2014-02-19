class ShiftsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if ['business'].include? current_user.role?
      @invitational = Invitational.new
      @shifts = Shift.all
      @table_shifts = @shifts
      @staffers = current_user.staffed_users.includes(:resume, :account)
    else
      @table_shifts = current_user.scheduled_shifts
      @shifts = @table_shifts.collect(&:to_calender_json)
    end
  end

  def show
    @shift = Shift.find(params[:id])
  end

  def new
    @staffers = current_user.staffed_users.includes(:resume, :account)
    @shift = Shift.new
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def create
    @shift = Shift.new(shift_params)

    respond_to do |format|
      if @shift.save
        format.html { redirect_to staffing_path, notice: 'Shift was successfully created.' }
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
    redirect_to :index
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

  def client_calendar
    @staffer = User.find(params[:user_id])
    @shifts = @staffer.scheduled_shifts
    @shifts = @shifts.before(params["end"]) if params["end"]
    @shifts = @shifts.after(params["start"]) if params["start"]
    @tableshifts = @shifts
    @shifts = @shifts.collect(&:to_calender_json)
  end

  def calendar
    @shifts = current_user.account.created_shifts
    @shifts = @shifts.before(params["end"]) if params["end"]
    @shifts = @shifts.after(params["start"]) if params["start"]
    @shifts = @shifts.collect(&:to_calender_json)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end

  def client_calendar_ajax
    @shifts = User.find(params[:user_id]).scheduled_shifts
    @shifts = @shifts.before(params["end"]) if params["end"]
    @shifts = @shifts.after(params["start"]) if params["start"]
    @shifts = @shifts.collect(&:to_calender_json)
    logger.debug @shifts.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end

  def clock_in
    @shift = Shift.find(params[:id])
    if current_user != @shift.user || current_user != @shift.account.owner
      redirect_to action: :index
    end
    @shift.clock_in(current_user.id, Time.now)
  end

  def clock_out
    @shift = Shift.find(params[:id])
    if (current_user != @shift.user) || (current_user != @shift.account.owner)
      redirect_to action: :index
    end
    @response = @shift.clock_out(current_user.id, Time.now)
    if @response.is_a? String
      flash[:notice] = @response
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
