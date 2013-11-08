class LineItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  monetize :rate_cents
  monetize :total_cents

  belongs_to :invoice
  belongs_to :task

  before_save :update_total

  validates :rate, presence: true
  validates :hours, presence: true
  validates :task_id, uniqueness: {scope: [:invoice_id], message: "already belongs to invoice"}, allow_nil: true

  private
    def update_total
      self.total = rate * hours
    end
end
