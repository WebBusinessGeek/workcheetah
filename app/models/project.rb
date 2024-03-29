class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :job
  belongs_to :owner, class_name: "User"
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users, uniq: true
  has_many :tasks, order: "position ASC", dependent: :destroy
  has_many :project_documents, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :invoices
  has_many :timesheets
  has_many :timesheet_entries, through: :timesheets

  scope :private_to_user, where(job_id: nil)
  scope :working, where("job_id != ?",nil)
  def private?
    !job_id
  end

  def total_unpaid_hours
    timesheets.includes(:timesheet_entries).where(status: "unpaid").sum(&:total_hours)
  end

  def total_hours
    timesheets.includes(:timesheet_entries).sum(&:total_hours)
  end

  def participants(current_user)
    @participants = users - [current_user]
  end

  def working?
    job_id?
  end
end
