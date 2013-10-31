class LineItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  monetize :rate_cents

  belongs_to :invoice
  belongs_to :task

  validates :invoice_id, presence: true
  validates :rate, presence: true
  validates :hours, presence: true
  validates :task_id, uniqueness: {scope: [:invoice_id], message: "already belongs to invoice"}, allow_nil: true

  def total
    rate_cents * hours
  end
end
