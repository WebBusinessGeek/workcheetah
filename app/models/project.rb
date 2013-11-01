class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :job
  belongs_to :owner, class_name: "User"
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users
  has_many :tasks, dependent: :destroy
  has_many :project_documents, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :invoices
  has_many :timesheets
  has_many :timesheet_entries, through: :timesheets
  has_many :unpaid_time_entries, through: :timesheets, source: :timesheet_entries, conditions: {status: "unpaid"}

  scope :private_to_user, where(job_id: nil)
  scope :working, where("job_id != ?",nil)
  def private?
    !job_id
  end

  def working?
    job_id?
  end
end
