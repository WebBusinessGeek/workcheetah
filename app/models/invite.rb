class Invite < ActiveRecord::Base
  attr_accessible :job_id, :resume_id

  # Associations
  belongs_to :job
  belongs_to :resume

  # Validations
  validates :job_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :resume_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
