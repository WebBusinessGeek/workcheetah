class ProjectsController < ApplicationController
  before_filter :load_project, only: [:show, :edit, :update, :destroy]
  def index
    @projects = current_user.projects.includes(:tasks)
  end

  def new
    @project = current_user.projects.new
  end

  def show
    @commentable = @project
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.owner = current_user

    if @project.save!
      redirect_to projects_path, notice: "Project Created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project successfully deleted."
  end

  private
    def load_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit()
    end
end
