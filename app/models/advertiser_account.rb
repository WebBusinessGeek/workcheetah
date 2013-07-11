class AdvertiserAccount < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user, conditions: { advertiser: true }
  has_many :campaigns, dependent: :destroy

end
