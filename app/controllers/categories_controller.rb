class CategoriesController < ApplicationController

  def index
    @category_list = Category.scoped.order(:name)
    check_session
    logger.debug @category
    @jobs = Job.scoped
    @jobs = @jobs.cat_search(@category) if @category
    @jobs = @jobs.search(@query) if @query
    @jobs = @jobs.near(human_readable_current_location, 50).includes(:account, :category).order("created_at DESC").page(params[:page]).per_page(8)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to categories_path, notice: "Category created"
  end

  def show
    @category = Category.find(params[:id])
    @jobs = @category.jobs.near(human_readable_current_location, 50).order("created_at DESC").page(params[:page]).per_page(8)

    if !@jobs.any? # if no jobs within next 50 miles
      @jobs = @category.jobs.near(current_location.state_code).order("created_at DESC").page(params[:page]).per_page(8)
      flash.now[:notice] = "There were no jobs near you, so here are some inside your state."
    end

    if !@jobs.any? # if still no jobs
      @jobs = @category.jobs.order("created_at DESC").page(params[:page]).per_page(8)
      flash.now[:notice] = "There were no jobs near you or in your state, so here are all jobs."
    end

    if @jobs.any?
      render "jobs/index"
    else # if still no jobs
      @articles = Article.order(:created_at).limit(10) if @jobs.empty?
      @query = @category.name
      @email_subscription = EmailSubscription.new
      render "jobs/getting_faster"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.assign_attributes(category_params)
    @category.save
    redirect_to categories_path, notice: "Category created"
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def check_session
      @query = params[:search] unless params[:search].blank?
      if params[:location]
        @location = params[:location]
      else
        @current_location = current_location
        @location ||= human_readable_current_location
      end
      if params[:categories]
        session[:categories] = params[:categories]
        @category = session[:categories]
      elsif user_signed_in? && current_user.resume.present?
        if session[:categories]
          @category = session[:categories]
        else
          @category = current_user.resume.recommended
        end
      else
        @category = session[:categories]
      end
      @category = @category.reject(&:blank?) if @category.class == Array
    end
end