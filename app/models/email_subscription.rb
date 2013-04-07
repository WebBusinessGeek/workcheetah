class EmailSubscription < ActiveRecord::Base
  # attr_accessible :email, :location, :query

  attr_accessor :return_url
end
