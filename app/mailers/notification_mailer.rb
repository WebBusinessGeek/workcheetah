class NotificationMailer < ActionMailer::Base
  default from: "support@workcheetah.com"

  def new_job_application(job_application)
    @job_application = job_application
    mail(:to => @job_application.job.account.users.first.email, :subject => "New Job Application")
  end

  def new_job(job)
    @job = job
    mail(:to => job.account.users.first.email, :subject => "YOUR JOB IS NOW LIVE ON WORKCHEETAH!")
  end

  def new_video_chat(video_chat)
  	@video_chat = video_chat
  	mail(to: video_chat.recipient.email, subject: "You received a new video interview request!")
  end

  def video_chat_update(video_chat, recipient)
  	@video_chat = video_chat
  	mail(to: recipient.email, subject: "Interview update")
  end

  def accept_video_chat(video_chat, recipient)
  	@video_chat = video_chat
  	mail(to: recipient.email, subject: "Interview accepted")
  end

  def video_chat_cancellation(video_chat, recipient)
  	@video_chat = video_chat
  	mail(to: recipient.email, subject: "Interview cancelled")
  end

  def new_claimable_job(job)
    @job = job
    mail(to: @job.email_for_claim, subject: "Your recent job post '#{@job.title}'")
  end

  def new_claimable_resume(resume)
    @resume = resume
    mail(to: @resume.email_for_claim, subject: "Your recent resume post #{@resume.name}")
  end
end
