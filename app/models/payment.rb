class Payment < ActiveRecord::Base
  attr_accessible :account_id, :amount, :params, :status, :stripe_charge_id, :stripe_transfer_id, :transfer, :type, :user_id

  serialize :params
end
