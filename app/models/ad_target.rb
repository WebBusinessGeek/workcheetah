class AdTarget < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  has_many :ad_targetings
  has_many :campaigns, through: :ad_targetings

  AUDIENCES = ["user", "business", "advertiser"]
  USER_TARGETS = ["Employed", "Unemployed", "Expecting Layoff"]
  BUSINESS_TARGETS = Account::ROLE_OPTIONS
  ADVERTISER_TARGETS = ["Marketing to Users", "Marketing to Businesses"]

  scope :by_audience, lambda {|a| where(audience: a)}
end
