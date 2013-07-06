class CommentsController < ApplicationController
	before_filter :user_signed_in?

	def create
		@comment = current_user.comments.create(params[:comment])
		redirect_to :back
	end
end
