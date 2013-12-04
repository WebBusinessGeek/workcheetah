class EstimateItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Invoicable

  belongs_to :estimate

  monetize :rate_cents
  monetize :total_cents

  # before_save :update_total

  def line_total
    hours * total_cents
  end

  # private
  #   def update_total
  #     self.total = rate * hours
  #   end
end
