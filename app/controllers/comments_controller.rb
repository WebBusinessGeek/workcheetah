class CommentsController < ApplicationController
	before_filter :user_signed_in?, :load_comment_type
  respond_to :html, :js

	def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save!
      redirect_to @commentable, notice: "Comment created."
    else
      redirect_to @commentable, notice: "Failed to create comment"
    end
  end

  private
    def load_comment_type
      klass = [Article, Project, Estimate].detect { |c| params["#{c.name.underscore}_id"] }
      @commentable = klass.find(params["#{klass.name.underscore}_id"])
    end

    def comment_params
    end
end
