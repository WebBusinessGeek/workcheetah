class AdTarget < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :ad_targetings
  has_many :campaigns, through: :ad_targetings

  #Class A - used to determine Class B targetings
  AUDIENCES = ["employee","freelancer", "business", "advertiser", "all"]
  #Class B1 - for [ business, freelancer] Uses Category Table to target industry offered by business
  INDUSTRY_TARGETS = []
  #class B2 - for [ employee, freelancer] Uses Category Table to target jobs
  JOB_TARGETS = []
  #Class B3 - for [ employee ]
  EMPLOYEE_TARGETS = ["Employed", "Unemployed", "Expecting Layoff"]
  #Class B4 - for [ employee, freelancer]
  EDUCATION_TARGETS = School::HIGHEST_MERIT
  #Class B5 - for [ advertiser ]
  ADVERTISER_TARGETS = ["Marketing to Users", "Marketing to Businesses"]

  scope :by_audience, lambda {|a| where(audience: a)}
  scope :by_target, lambda {|t| where(name: t)}
end
