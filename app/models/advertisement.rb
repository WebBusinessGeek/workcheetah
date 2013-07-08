class Advertisement < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :campaign
  has_one :ad_stat

  def toggle!
    return update_attribute(:active, false) if active?
    return update_attribute(:active, true) unless active?
  end
end
