class ArticlesController < ApplicationController
  before_filter :authorize_admin!, except: [ :show, :index ]

  def index
    @articles = Article.scoped
  end

  def show
    load_article
    session[:viewed_articles] ||= []
    if !session[:viewed_articles].include? @article.id
      @article.view_count += 1
      @article.save
      session[:viewed_articles] << @article.id
    end

    @comments = @article.comments.order('created_at DESC')
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

  def destroy
    load_article
    @article.destroy
    redirect_to articles_path, notice: "Article destroyed successfully."
  end

private

  def article_params
    params.require(:article).permit(:blog_category_id, :body, :cover, :slug, :subtitle, :title)
  end

  def load_article
    if params[:id].to_i == 0
      @article = Article.where(slug: params[:id]).first
    else
      @article = Article.find(params[:id])
    end
  end

end