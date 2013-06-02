class BlocksController < ApplicationController
	before_filter :user_signed_in?

	def create
		Block.create(blocker_id: current_user.id, blocked_id: params[:id])
		redirect_to :back, notice: "Blocked."
	end

	def destroy
		Block.where(blocker_id: current_user.id, blocked_id: params[:id]).destroy_all
		redirect_to :back, notice: "Unblocked."
	end
end
