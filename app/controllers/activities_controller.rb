class ActivitiesController < ApplicationController
  def index
    @activities = current_user.activities.order('updated_at desc') if current_user
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
  end
end
