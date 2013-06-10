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

  def seal_purchase(user)
    mail(to: user.email, subject: "Workcheetah Seal Purchase", bcc: "kevin@workcheetah.com")
  end

  def new_job_invite(job, resumes)
    @job = job
    emails = []
    resumes.each { |resume| emails << resume.user.email }
    mail(to: "support@workcheetah.com", bcc: emails, subject: "You have been invited to apply for a job!")
  end

  def new_conversation(conversation, recipient)
    @conversation = conversation
    mail(to: recipient.email, subject: "New message")
  end

  def message_to_all(conversation)
    @conversation = conversation
    emails = []
    @conversation.last.participants.each { |participant| emails << participant.user.email }
    mail(to: "support@workcheetah.com", bcc: emails, subject: "The system admin has sent you a message.")
  end
end
