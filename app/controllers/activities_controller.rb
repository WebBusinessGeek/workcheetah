class ActivitiesController < ApplicationController
  def index
    @activities = current_user.activities.order('updated_at desc') if current_user
  end
end
