class DashboardsController < ApplicationController
  layout "home"


  def home
    @articles = Article.order('created_at desc').limit(10)
    @visitors_ip = Rails.env.development? ? "71.197.119.115" : request.remote_ip

    @current_location = Geocoder.search(@visitors_ip).first
    if @current_location
      @current_location_clean = [@current_location.city, @current_location.state].map{ |x| x if x.present? }.join(", ")
    else
      @current_location_clean = ""
    end
  end

  def admin
    authorize_admin_user!
    @jobs = Job.order('created_at desc').limit(10)
    @resumes = Resume.order('created_at desc').limit(10)
    @jobs_count = Job.scoped.count
    @applicant_accesses = ApplicantAccess.order('created_at desc').limit(10)
    @applicant_accesses_count = ApplicantAccess.order('created_at desc').count
    @applicant_accesses_today_count = ApplicantAccess.where(created_at: Date.today).order('created_at desc').count
    @applicant_accesses_last_7_days_count = ApplicantAccess.where(created_at: 7.days.ago..Date.today).order('created_at desc').count
    @applicant_accesses_last_28_days_count = ApplicantAccess.where(created_at: 28.days.ago..Date.today).order('created_at desc').count
    @accounts = Account.order('created_at desc').limit(10)
  end
end