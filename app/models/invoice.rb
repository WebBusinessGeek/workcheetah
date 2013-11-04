class Invoice < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  APPLICATION_FEE = 0.03
  PAYMENT_FEE = 0.027
  belongs_to :sender, class_name: "Account"
  belongs_to :recipient, class_name: "Account"
  belongs_to :project
  has_many :line_items, dependent: :destroy

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
    event :success do
      transition :processing => :finished
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

    before_transition :pending => :processing do |invoice|
      # unless escrow?
      # charge_card_immediately and transfer funds
      # if charge_card success call success else failure
      # else
      # charge_card_immediately but do not transfer funds
      # if charge_carge success call in_escrow else failure
      # end
    end
  end

  def to_param
    guid
  end

  def client_name
    if recipient
      recipient.name
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

  def invoice_total
    Money.new((amount * (1 + PAYMENT_FEE + APPLICATION_FEE)) + Money.new(30))
  end

  private
    def generate_guid
      self.guid = SecureRandom.urlsafe_base64(8)
    end

    def update_total
      amount = line_total
    end
end