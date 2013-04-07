class ApplicantAccess < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :job_application
  belongs_to :account

  PRICE_PER_APPLICANT = 99
  # attr_accessible :title, :body
end
