class TimedShift < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :user
  belongs_to :shift

  before_save :update_total_time

  scope :started, where('start_time IS NOT NULL AND end_time IS NULL')
  scope :ended, where('start_time IS NOT NULL AND end_time IS NOT NULL')

  private
    def update_total_time
      if self.end_time && self.start_time
        self.total_time = ((self.end_time - self.start_time) / 3600).round(2)
      end
      if !self.end_time && self.start_time
        self.total_time = ((Time.now - self.start_time) / 3600).round(2)
      end
    end
end
