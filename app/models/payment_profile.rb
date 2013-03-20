class PaymentProfile < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :account
  # attr_accessible :cc_number_preview, :expiration, :nickname, :stripe_customer_token

  attr_accessor :stripe_card_token

  scope :active, -> { where(status: "active") }

  before_create :get_stripe_customer_token

  # private

  def get_stripe_customer_token
    customer = Stripe::Customer.create( card: self.stripe_card_token )
    self.stripe_customer_token = customer.id
  end
end
