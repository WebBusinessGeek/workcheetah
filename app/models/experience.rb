class Experience < ActiveRecord::Base
  attr_accessible :company_name, :job_title, :from, :till, :highlights, :resume_id, :current_employer

  belongs_to :resume
end
