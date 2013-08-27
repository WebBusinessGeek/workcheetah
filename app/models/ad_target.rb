class AdTarget < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :ad_targetings
  has_many :campaigns, through: :ad_targetings

  EMPLOYEE_TARGETS = ["Employed", "Unemployed", "Expecting Layoff"]
  ADVERTISER_TARGETS = ["Marketing to Users", "Marketing to Businesses"]
  EDUCATION_TARGETS = School::HIGHEST_MERIT

  scope :by_audience, lambda {|a| where(audience: a)}
  scope :by_target, lambda {|t| where(name: t)}

  def self.business_targets
    Category.order(:name).pluck(:name)
  end
end
