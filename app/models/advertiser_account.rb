class AdvertiserAccount < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user, conditions: { advertiser: true }
  has_many :campaigns, dependent: :destroy
  has_many :payment_profiles, as: :accountable, dependent: :destroy

  def has_payment_profile?
    self.payment_profiles.any?
  end

end
