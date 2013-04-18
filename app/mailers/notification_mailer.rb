class NotificationMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def new_job_application(job_application)
    @job_application = job_application
    mail(:to => @job_application.job.account.users.first.email, :subject => "New Job Application")
  end
end
