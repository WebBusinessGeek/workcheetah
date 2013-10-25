class ApplicantAccess < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :applicable, polymorphic: true
  belongs_to :account

end
