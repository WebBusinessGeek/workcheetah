class AdvertiserAccount < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  has_many :campaigns, dependent: :destroy
end
