class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :addressable_id, :addressable_type, :city, :country_id, :latitude, :longitude, :state, :zip
  belongs_to :addressable, polymorphic: true

  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :addressable_id, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

  def city_state
    "#{city}, #{state}"
  end
end