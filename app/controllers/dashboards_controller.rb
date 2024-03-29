class DashboardsController < ApplicationController
  layout "home", only: [:admin, :moderator]

  before_filter :authorize_admin!, only: [ :admin ]
  before_filter :authorize_moderator!, only: [ :moderator ]
  before_filter :load_activities

  def home
    @visitors_ip = Rails.env.development? ? "71.197.119.115" : request.remote_ip

    if user_signed_in?
      @todos = current_user.todos.where(date: Date.today)

      @sidebar_ads = Advertisement.by_target(current_user.target_params)
      Advertisement.batch_stat_incrementor "impression", @sidebar_ads.pluck(:id)

      if ['Business'].include?(current_user.role?)
        if params[:offset].present?
          @business_ads_group = Advertisement.order('priority').offset(params[:offset]).take(10)
        else
          @business_ads_group = Advertisement.order('priority').offset(0).take(10)
        end
      elsif ['Freelancer'].include?(current_user.role?)
        if params[:offset].present?
          @freelancer_ads_group = Advertisement.order('priority').offset(params[:offset]).take(8)
        else
          @freelancer_ads_group = Advertisement.order('priority').offset(0).take(8)
        end
      end

      if ['Business'].include?(current_user.role?)
        cat = BlogCategory.find_by_name('For Businesses')
        @business_articles = cat.articles if cat.present?
      elsif ['Freelancer'].include?(current_user.role?)
        cat = @freelancing_articles = BlogCategory.find_by_name('For Freelancers')
        @freelancing_articles = cat.articles if cat.present?
      else
        cat = BlogCategory.find_by_name('For Employees')
        @employee_articles = cat.articles if cat.present?
      end
    else
      @articles = Article.order('created_at desc').limit(10)
    end
  end

  def admin
    @jobs = Job.order('created_at desc').limit(10)
    @resumes = Resume.order('created_at desc').limit(10)
    @jobs_count = Job.scoped.count
    #TODO: Move this to a single query
    @applicant_accesses = ApplicantAccess.order('created_at desc').limit(10)
    @applicant_accesses_count = ApplicantAccess.order('created_at desc').count
    @applicant_accesses_today_count = ApplicantAccess.where(created_at: Date.today).order('created_at desc').count
    @applicant_accesses_last_7_days_count = ApplicantAccess.where(created_at: 7.days.ago..Date.today).order('created_at desc').count
    @applicant_accesses_last_28_days_count = ApplicantAccess.where(created_at: 28.days.ago..Date.today).order('created_at desc').count

    @accounts = Account.order('created_at desc').limit(10)

    @moderators = User.where(moderator: true)

    @seal_purchases = SealPurchase.order('created_at DESC').limit(10)
  end

  def moderator
    @job = Job.new
    @resume = Resume.new
  end

  def job_info
  end

  def ad_info
    @signup = AdvertiserSignUp.new
  end

  def resume_info
  end

  def fetch_ads_group
    @ads_group = Advertisement.order('priority').offset(params[:offset]).take(10) if params[:offset].present?
    render nothing: true
  end

  private

  def load_activities
    @activities = current_user.activities.order('updated_at desc').limit(10) if current_user
  end
end
