class TimedShift < ActiveRecord::Base
  belongs_to :user
  belongs_to :shift
  attr_accessible :end_time, :start_time, :total_time.float
end
