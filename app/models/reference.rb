class Reference < ActiveRecord::Base
  # attr_accessible :company, :email, :job_title, :name, :notes, :phone, :reference_type
  belongs_to :resume
  has_one :confirmation, as: :confirmable

  attr_accessible :name, :job_title, :company, :phone, :email, :notes, :reference_type, :resume_id
  BUSINESS_TYPES_COLLECTION = [ ['Start-up (less than 1 year in operation)', 'start-up'], ['Small Business (less than 1 million in annual revenue)', 'small'], ['Corporation (more than 1 million in annual revenue)', 'corporation'], ['Big Business (more than 10 million in annual revenue)', 'big'], ['Sole Proprietor', 'sole-proprietor'] ]
  attr_accessor :business_types

  def confirm!
    unless confirmed?
      update_column(:confirmed, true)
      confirmation.update_column(:confirmated_at, Time.now)
    end
  end
end
