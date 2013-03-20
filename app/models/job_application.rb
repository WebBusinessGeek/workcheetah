class JobApplication < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :job
  belongs_to :user
  has_many :applicant_accesses
  # attr_accessible :status
end
