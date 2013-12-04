class LineItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Invoicable
  monetize :rate_cents
  monetize :total_cents

  belongs_to :invoice
  belongs_to :task

  # before_save :update_total

  validates :task_id, uniqueness: {scope: [:invoice_id], message: "already belongs to invoice"}, allow_nil: true

  # private
  #   def update_total
  #     self.total = rate * hours
  #   end
end
