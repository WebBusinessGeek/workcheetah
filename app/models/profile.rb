class Profile < ActiveRecord::Base
  # attr_accessible :distance_importance, :email, :freedom_importance, :growth_importance, :name, :pay_importance, :phone, :status, :website

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :schools, dependent: :destroy
  has_many :references, dependent: :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :schools
  accepts_nested_attributes_for :references
  accepts_nested_attributes_for :experiences
end
