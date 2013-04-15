class JobApplication < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :job, counter_cache: true
  belongs_to :user
  has_one :applicant_access
  # attr_accessible :status
end
