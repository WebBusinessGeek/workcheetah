class Task < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :projects
  belongs_to :users

  scope :due, ->(date) { where(due_date: date) }
end
