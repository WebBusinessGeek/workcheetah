class Shift < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user, foreign_key: "employee_id"
  belongs_to :account, foreign_key: "creator_id"

  before_save :update_total_hours

  scope :current_week, where(schedule_date: Date.today.at_beginning_of_week..Date.today.at_end_of_week)
  private
    def update_total_hours
      shift_hours = end_hour.hour - start_hour.hour
    end
end
