class Campaign < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertiser_account
  has_many :advertisements

  def toggle_status!
    return update_attribute(:active, false) if active?
    return update_attribute(:active, true) unless active?
  end
end
