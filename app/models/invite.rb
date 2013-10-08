class Invite < ActiveRecord::Base
  PRICE = [[15, 500],[75, 2000],[300, 5000]]

  attr_accessible :job_id, :resume_id

  belongs_to :job
  belongs_to :resume

  validates :job_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :resume_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
