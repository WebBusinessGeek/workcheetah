class Invoice < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :sender, class_name: "Account"
  belongs_to :recipient, class_name: "Account"
  belongs_to :project
  has_many :line_items, dependent: :destroy

  monetize :amount_cents

  before_create :generate_guid

  def client_name
    recipient.name
  end

  private
    def generate_guid
      self.guid = SecureRandom.uuid()
    end
end
