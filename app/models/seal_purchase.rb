class SealPurchase < ActiveRecord::Base
  attr_accessible :account_id, :amount

  belongs_to :account

  validates :account_id, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { only_integer: true }
end
