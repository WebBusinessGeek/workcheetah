class JobMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def job_flagged(job, reporter_ip, user = nil)
    @job = job
    @reporter_ip = reporter_ip
    @user = user
    mail(to: "support@workcheetah.com", subject: "Job Flagged")
  end
end