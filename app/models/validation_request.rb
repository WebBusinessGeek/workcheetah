class ValidationRequest < ActiveRecord::Base
  belongs_to :account
  attr_accessible :commission_only, :ein, :industry, :length_of_business, :name, :ssn

  validates :account_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :commission_only, presence: true
  validates :ein, presence: true, format: { with: /\d{2}-\d{7}/, message: "must look something like 12-1234567" }
  validates :name, presence: true
end
