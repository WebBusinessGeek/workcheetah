class JobApplication < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :job, counter_cache: true
  belongs_to :user
  has_one :applicant_access, as: :applicable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  NOTES = ["Interview Scheduled","Had Interview", "Have not spoken to",
    "Contact made", "Not Interested", "Interested"]

  after_create :creation_notification
  after_update :change_notification
  after_destroy :destruction_notification

  def creation_notification
    self.notifications.create(body: "Someone has applied to one of your jobs.", user_id: self.job.account.owner)
  end

  def change_notification
    self.notifications.create(body: "Your job application has been changed.", user_id: self.job.account.owner)
    self.notifications.create(body: "Your job application has been changed.", user_id: self.user_id)
  end

  def destruction_notification
    Notification.create(body: "Your job application has been destroyed.", user_id: self.job.account.owner)
    Notification.create(body: "Your job application has been destroyed.", user_id: self.user_id)
  end

  def hire!(paytype)
    if paytype == "salary"
      create_applicant_access account: job.account, job: job, hourly: false
    else
      create_applicant_access account: job.account, job: job, hourly: true
    end
    self.update_attribute(:status, "accepted")
    #3 Send Accepted Job Application mailer
    # Add :user to job owners staff list
    job.account.owner.add_staffer!(user)
    ids = job.job_application_ids - [id]
    JobApplication.update_all({status: "Declined"}, {id: ids}) unless ids.empty?
    #4 Send mass rejection mailer for performance benefit using ids
    @project = Project.create! title: job.title, job: job
    @project.owner = job.account.owner
    @project.users << @project.owner
    @project.users << user
  end

  def reject!
    self.update_attribute(:status, "Declined")
    # Send Rejected Job Application mailer
  end

  def rejected?
    self.status == "Declined"
  end
end
