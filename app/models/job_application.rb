class JobApplication < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :job, counter_cache: true
  belongs_to :user
  has_one :applicant_access, dependent: :destroy
  # attr_accessible :status

  def reject!
    self.update_attribute(:status, "Declined")
  end

  def rejected?
    self.status == "Declined"
  end
end
