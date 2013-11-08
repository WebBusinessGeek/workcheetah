class Shift < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user, foreign_key: "employee_id"
  belongs_to :account, foreign_key: "creator_id"

  before_save :update_total_hours
  validates :schedule_date, :start_hour, :end_hour, presence: true
  scope :current_week, where(schedule_date: Date.today.at_beginning_of_week..Date.today.at_end_of_week)
  scope :between_these, ->(start_date, end_end) {where(schedule_date: start_date..end_date)}

  def title
    "#{shift_hours} hour shift for #{user.email}"
  end

  def to_calender_json(options={})
    {
      id: self.id,
      title: self.title,
      start: self.start_hour,
      end: self.end_hour,
      url: "/shifts/#{self.id}",
      allDay: false,
      recurring: false
    }
  end

  private
    def update_total_hours
      self.shift_hours = (self.end_hour.hour - self.start_hour.hour)
    end
end
