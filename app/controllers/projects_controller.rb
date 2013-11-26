class ProjectsController < ApplicationController
  before_filter :load_project, only: [:show, :edit, :update, :destroy, :invite]
  def index
    # @projects = current_user.projects.includes(:tasks)
    # ensure proper ordering by position on join table
    @projects = current_user.projects_users.includes(project: [:tasks])
  end

  def new
    @project = current_user.projects.new
  end

  def show
    authorize! :read, @project
    @invitational = Invitational.new
    @commentable = @project
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.owner = current_user
    @project.users << current_user

    if @project.save!
      redirect_to projects_path, notice: "Project Created"
    else
      render :new
    end
  end

  def edit
    authorize! :edit, @article
  end

  def update
    authorize! :update, @article
    if @project.update_attributes(project_params)
    end
  end

  def destroy
    authorize! :destroy, @article
    @project.destroy
    redirect_to projects_path, notice: "Project successfully deleted."
  end

  def sort
    params[:projects_user].each_with_index do |id, index|
        pu = current_user.projects_users.find id
        pu.update_attribute :position, index if pu
    end
    render nothing: true
  end

  def invite
    @invitational = Invitational.new(
      email: params[:invitational][:email],
      name: params[:invitational][:name],
      type: "Project",
      type_id: params[:id]
    )
    if @invitational.save
      redirect_to project_path(@project), notice: "Invited User successfully"
    else
      logger.debug @invitational.inspect
      render 'projects/invite'
    end
  end

  private
    def load_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title)
    end
end
