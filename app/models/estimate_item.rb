class EstimateItem < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :estimate

  monetize :total_cents

  def line_total
    hours * total
  end
end
