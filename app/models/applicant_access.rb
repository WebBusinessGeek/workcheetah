class ApplicantAccess < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :job_application
  belongs_to :account
  # attr_accessible :title, :body
end
