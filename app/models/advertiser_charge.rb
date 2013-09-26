class AdvertiserCharge < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertiser_invoice
  belongs_to :campaign

  monetize :amount_cents

  def total
    amount * quantity
  end
end
