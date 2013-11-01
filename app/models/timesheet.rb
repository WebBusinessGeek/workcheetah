class Timesheet < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :project
  belongs_to :user
  has_many :timesheet_entries, dependent: :destroy

  accepts_nested_attributes_for :timesheet_entries, allow_destroy: true

  scope :current
end
