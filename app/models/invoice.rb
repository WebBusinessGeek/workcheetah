class Invoice < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :sender, class_name: "Account"
  belongs_to :recipient, class_name: "Account"
  belongs_to :project
  has_many :line_items, dependent: :destroy

  monetize :amount_cents

  before_create :generate_guid
  before_save :update_total

  state_machine initial: :pending do
    event :charge do
      transition :pending => :processing
    end
    event :success do
      transition :processing => :finished
    end
    event :failure do
      transition :processing => :errored
    end

    before_transition :pending => :processing do |invoice|
      # charge_card
      puts invoice.total_charge
    end
  end

  def client_name
    recipient.name
  end

  private
    def generate_guid
      self.guid = SecureRandom.uuid()
    end

    def update_total
      self.amount = line_items.sum(&:total)
    end
end
