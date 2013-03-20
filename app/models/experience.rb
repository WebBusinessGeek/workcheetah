class Experience < ActiveRecord::Base
  belongs_to :profile
  # attr_accessible :company_name, :from, :highlights, :job_title, :till
end
