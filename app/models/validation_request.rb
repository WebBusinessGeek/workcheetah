class ValidationRequest < ActiveRecord::Base
  belongs_to :account
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  attr_accessible :address_attributes, :commission_only, :contact_person, :contact_email, :contact_phone, :ein, :independent_distributorship_opportunity, :industry, :length_of_business, :name, :profit, :ssn

  validates :account_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :ein, format: { with: /\d{2}-\d{7}/, message: "must look something like 12-1234567" }, allow_blank: true
  validates :name, presence: true
  validates :contact_person, presence: true
  validates :contact_email, presence: true, format: { with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i, message: "is invalid" }
end
