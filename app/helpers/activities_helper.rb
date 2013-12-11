module ActivitiesHelper
  def render_activity activity, args = {}
    case activity.trackable_type
    when "JobApplication"
      render 'activities/job_application', {activity: activity}
    when "Job"
      render 'activities/job', {activity: activity}
    when "Estimate"
      render 'activities/estimate', {activity: activity}
    end
  end
end
