class Payment < ActiveRecord::Base
  attr_accessible :account_id, :amount, :params, :status, :stripe_charge_id, :stripe_transfer_id, :transfer, :type, :user_id

  STRIPE_FEE = 0.027
  APP_FEE = 0.013
  serialize :params

  def total
    (amount * (1 + STRIPE_FEE + APP_FEE)).round
  end
end
