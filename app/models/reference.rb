class Reference < ActiveRecord::Base
  # attr_accessible :company, :email, :job_title, :name, :notes, :phone, :reference_type
  belongs_to :resume
  has_one :confirmation, as: :confirmable, dependent: :destroy

  attr_accessible :name, :job_title, :company, :phone, :email, :notes, :reference_type, :resume_id, :feedback
  validates :email, presence: true
  def confirm!
    unless confirmed?
      update_column(:confirmed, true)
      confirmation.update_column(:confirmated_at, Time.now)
    end
  end
end
