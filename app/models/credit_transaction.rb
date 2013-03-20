class CreditTransaction < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :account
  belongs_to :credit_package
  belongs_to :payment_profile

  attr_accessor :stripe_card_token

  accepts_nested_attributes_for :payment_profile

  before_create :update_attributes_to_match_credit_package
  after_create :process_transaction

  def process_transaction
    charge_payment
    apply_credit
  end

  def charge_payment
    Stripe::Charge.create(
      :amount => (self.amount * 100).to_i,
      :currency => "usd",
      :customer => self.account.payment_profiles.last.stripe_customer_token,
      # :card => @payment_profile.stripe_customer_token,
      :description => "Transaction ID: ##{self.id}"
    )
  end

  def apply_credit
    @old_credit_count = 0
    @old_credit_count += self.account.credits if self.account.credits
    @old_credit_count += self.quantity
    self.account.update_attribute(:credits, @old_credit_count)
  end

  def update_attributes_to_match_credit_package
    self.quantity = self.credit_package.quantity
    self.amount = self.credit_package.cost
  end

end
