class TasksController < ApplicationController
  before_filter :load_task, only: [:show, :update, :edit, :destroy, :complete]

  respond_to :html, :js
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    if @task.save
      respond_with @task
    end
  end

  def update
    @task.update_attributes(task_params)
    redirect_to @task.project, notice: "Task succesfully updated."
  end

  def edit
  end

  def destroy
    @task.destroy
  end

  def sort
    params[:task].each_with_index do |id, index|
        task = Task.find id
        task.update_attributes(position: index, state: params[:status]) if task
    end
    render nothing: true
  end

  private
    def load_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :due_date, :project_id)
    end
end
