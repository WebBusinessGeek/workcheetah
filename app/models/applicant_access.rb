class ApplicantAccess < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :applicable, polymorphic: true
  belongs_to :account
  belongs_to :job
  delegate :user, to: :applicable

  def salary?
    !hourly?
  end
end
