class TimesheetEntry < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :timesheet
  belongs_to :task

  validates :date, presence: true
  validates :hours, presence: true
  validates :hours, numericality: true
end
