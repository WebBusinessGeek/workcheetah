class PaymentProfile < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :account
  # attr_accessible :cc_number_preview, :expiration, :nickname, :stripe_customer_token

  attr_accessor :stripe_card_token
  attr_accessor :first_job_applicant_to_buy

  scope :active, -> { where(status: "active") }

  before_create :get_stripe_customer_token

  # private

  def get_stripe_customer_token
    customer = Stripe::Customer.create( card: self.stripe_card_token )
    self.stripe_customer_token = customer.id
    self.cc_number_preview = customer.active_card.last4
    self.expiration = [customer.active_card.exp_month, customer.active_card.exp_year].join("/")
  end
end
