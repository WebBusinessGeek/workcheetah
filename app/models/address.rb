class Address < ActiveRecord::Base
  # attr_accessible :address_1, :address_2, :addressable_id, :addressable_type, :city, :country_id, :latitude, :longitude, :state, :zip
  belongs_to :addressable, polymorphic: true
end
