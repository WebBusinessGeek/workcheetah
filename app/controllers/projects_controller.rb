class ProjectsController < ApplicationController
  before_filter :load_project, only: [:show, :edit, :update, :destroy, :invite]
  def index
    # @projects = current_user.projects.includes(:tasks)
    # ensure proper ordering by position on join table
    @owned_projects, @callaboration_projects, = [],[]
    if ['freelancer','business'].include? current_user.role && !current_user.account.nil?
      @revenue = current_user.account.sent_invoices.with_state("payout","finished").sum(&:amount_cents)
    end
    @projects = current_user.projects_users.includes(:project)
    @projects.each do |project|
      if project.project.owner_id == current_user.id
        @owned_projects << project
      else
        @callaboration_projects << project
      end
    end
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
    authorize! :edit, @project
  end

  def update
    authorize! :update, @project
    if @project.update_attributes(project_params)
      redirect_to projects_path, notice: "Project successfully updated."
    end
  end

  def destroy
    authorize! :destroy, @project
    @project.delay.destroy_notifications
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
