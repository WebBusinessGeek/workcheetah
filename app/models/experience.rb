class Experience < ActiveRecord::Base
  belongs_to :resume
  # attr_accessible :company_name, :from, :highlights, :job_title, :till
  attr_accessible :company_name, :job_title, :from, :till, :highlights, :resume_id, :current_employer
end
