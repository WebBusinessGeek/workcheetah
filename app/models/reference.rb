class Reference < ActiveRecord::Base
  # attr_accessible :company, :email, :job_title, :name, :notes, :phone, :reference_type
  belongs_to :resume
  has_one :confirmation, as: :confirmable

  attr_accessible :name, :job_title, :company, :phone, :email, :notes, :reference_type, :resume_id

  def confirm
  end
end
