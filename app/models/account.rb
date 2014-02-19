class Account < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  ROLE_OPTIONS = [ "Hiring Manager", "CEO", "Business Owner", "Human Resource Manager", "Entrepreneur", "General Manager", "Independent Distributor", "Marketing Manager", "Sales Manager", "District Manager", "Regional Manager", "Account Executive", "Vice President", "President", "Director", "Partner" ]

  has_many :jobs, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :applicant_accesses, dependent: :destroy
  has_many :applicables, through: :applicant_accesses
  has_many :payment_profiles, as: :accountable, dependent: :destroy
  has_many :seal_purchases, dependent: :destroy
  has_many :sent_invoices, class_name: "Invoice", foreign_key: "sender_id"
  has_many :recieved_invoices, class_name: "Invoice", foreign_key: "reciever_id"
  has_many :created_shifts, class_name: "Shift", foreign_key: "creator_id"
  has_many :payments
  # validates :name, presence: true
  # validates :slug, presence: true, uniqueness: true

  mount_uploader :logo, LogoUploader

  accepts_nested_attributes_for :users

  def owner
    users.first
  end

  def has_credits?
    self.credits && self.credits > 0
  end

  def has_invite_credits?
    self.invite_credits && self.invite_credits > 0
  end

  def has_estimate_credits?
    self.estimate_credits && self.estimate_credits > 0
  end

  def decrement_credit(type)
    current = send "#{type.to_sym}_credits"
    update_column("#{type.to_sym}_credits", current - 1)
  end

  def has_payment_profile?
    self.payment_profiles.any?
  end

  def buy_credits(type, price_array)
    if has_payment_profile?
      @payment_profile = self.payment_profiles.first
      @response = Stripe::Charge.create(
        :amount      => price_array.last,
        :currency    => "usd",
        :customer    => @payment_profile.stripe_customer_token,
        :description => "Charge for #{price_array.first} #{type.pluralize}"
      )
      if @response.failure_message.nil?
        current = send "#{type.to_sym}_credits"
        self.update_attribute("#{type.to_sym}_credits", current + price_array.first)
        # TODO add record of transaction to a more central transaction model
      end
      @response
    end
  end

  def buy_seal
    if has_payment_profile?
      @payment_profile = self.payment_profiles.first
      @response = Stripe::Charge.create(
        :amount      => PaymentProfile::SAFE_SEAL_PRICE,
        :currency    => "usd",
        :customer    => @payment_profile.stripe_customer_token,
        :description => "Charge for Safe Job seal"
      )
      if @response.failure_message.nil?
        self.update_attribute(:safe_job_seal, true)
        self.seal_purchases.create(amount: PaymentProfile::SAFE_SEAL_PRICE)
      end
      @response
    end
  end
end
