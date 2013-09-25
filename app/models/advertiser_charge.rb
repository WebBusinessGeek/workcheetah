class AdvertiserCharge < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertiser_invoice

  monetize :amount_cents

  def total
    amount * quantity
  end
end
