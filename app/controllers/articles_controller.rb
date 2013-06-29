class ArticlesController < ApplicationController
  def index
    @articles = Article.scoped
  end

  def show
    load_article
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  def edit
    load_article
  end

  def update
    load_article
    @article.assign_attributes(article_params)
    @article.save
    redirect_to @article
  end

  private

  def article_params
    params.require(:article).permit(:body, :cover, :slug, :subtitle, :title)
  end

  def load_article
    if params[:id].to_i == 0
      @article = Article.where(slug: params[:id]).first
    else
      @article = Article.find(params[:id])
    end
  end

end