class AdvertiserAccount < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_one :advertiser, class_name: "User",
                       foreign_key: "account_id",
                       inverse_of: :advertiser_account,
                       dependent: :destroy
end
