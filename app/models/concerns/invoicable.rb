module Invoicable
  extend ActiveSupport::Concern

  included do
    validates :rate, presence: true
    validates :hours, presence: true
    before_save :update_total
  end

  private
    def update_total
      self.total = rate * hours
    end
end