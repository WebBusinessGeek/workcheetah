class TasksController < ApplicationController
  before_filter :load_task, only: [:show, :update, :edit, :destroy]

  respond_to :html, :js
  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      respond_with @task
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
    def load_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :due_date, :project_id)
    end
end
