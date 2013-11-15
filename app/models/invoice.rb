class Invoice < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  APPLICATION_FEE = 0.03
  PAYMENT_FEE = 0.027
  belongs_to :sender, class_name: "Account"
  belongs_to :reciever, class_name: "Account"
  belongs_to :project
  has_many :line_items, dependent: :destroy

  attr_accessor :email, :name

  accepts_nested_attributes_for :line_items, reject_if: :all_blank, allow_destroy: true

  monetize :amount_cents

  before_create :generate_guid
  before_update :update_total

  state_machine initial: :draft do
    event :send_invoice do
      transition :draft => :sent
    end
    event :accept do
      transition :sent => :pending
    end
    # normal payment workflow
    event :charge do
      transition :pending => :processing
    end
    event :pay_out do
      transition :processing => :payout
    end
    event :success do
      transition :payout => :finished
    end
    event :failure do
      transition :processing => :errored
    end
    # escrow payment workflow
    event :put_in_escrow do
      transition :pending => :processing
    end
    event :in_escrow do
      transition :processing => :escrowed
    end
    event :transfer_funds do
      transition :escrowed => :finished
    end

    after_transition :pending => :processing do |invoice|
      unless invoice.escrow?
        invoice.charge_reciever
      else
        invoice.charge_reciever(is_escrow: true)
      end
    end

    before_transition :escrowed => :finished do |invoice|
      invoice.request_transfer
    end

    before_transition :payout => :finished do |invoice|
      invoice.request_transfer
    end
  end

  def to_param
    guid
  end

  def client_name
    if reciever
      reciever.name
    else
      "None"
    end
  end

  def project_name
    if project
      project.title
    else
      "None"
    end
  end

  def line_total
    line_items.sum(&:total)
  end

  def application_fee_total
    amount_cents * APPLICATION_FEE
  end

  def payment_fee_total
    amount_cents * PAYMENT_FEE + 30
  end

  def invoice_total
    amount_cents + payment_fee_total.to_i + application_fee_total.to_i
  end

  def transfer_total
    amount_cents - 25
  end

  def charge_reciever(is_escrow = false)
    begin
      save!
      charge = Stripe::Charge.create(
        amount: self.invoice_total,
        currency: "usd",
        customer: self.reciever.payment_profiles.first.stripe_customer_token,
        description: "Invoice Charge for #{self.amount} from #{self.reciever.owner.email}"
      )
      self.update_attributes(stripe_charge_id: charge.id)
      if is_escrow
        self.in_escrow
      else
        self.pay_out
      end
    rescue Stripe::CardError => e
      self.update_attributes(error: e.message)
      self.failure
    end
  end

  def request_transfer
    transfer = Stripe::Transfer.create(
      amount:      self.transfer_total,
      currency:    'usd',
      recipient:   self.sender.owner.stripe_recipient_id,
      description: "Transfer #{self.amount} to #{self.sender.owner.email}"
    )
    if transfer.error_message.nil?
      self.success
    else
      self.update_attributes(message: transfer.error_message, state: "errored")
    end
  end

  private
    def generate_guid
      self.guid = SecureRandom.urlsafe_base64(8)
    end

    def update_total
      self.amount = line_total
    end
end
