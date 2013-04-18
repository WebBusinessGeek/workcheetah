class CategoriesController < ApplicationController
  def index
    @categories = Category.scoped.order(:name)
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
    @jobs = @category.jobs
    render "jobs/index"
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
end