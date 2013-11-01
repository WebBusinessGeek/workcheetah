class TimesheetsController < ApplicationController
  before_filter :load_project
  respond_to :html, :js
  def index
    if @project
      @timesheets = @project.timesheets
    else
      @timesheets = current_user.timesheets
    end
  end

  def new
    @timesheet = @project.timesheets.build
    @timesheet.timesheet_entries.build
  end

  def show
  end

  def edit
  end

  def create
    @timesheet = @project.timesheets.new(timesheet_params) if @project

    if @timesheet.save
      redirect_to @project, notice: "Time entry saved succesfully"
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
    def load_project
      @project = Project.find(params[:project_id])
    end

    def timesheet_params
      params.require(:timesheet).permit(:project_id, :user_id,
                                          timesheet_entries_attributes: [:id, :timesheet_id, :date, :hours, :note, :task_id, :_destroy])
    end
end