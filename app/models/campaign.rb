class Campaign < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertiser_account
  has_many :advertisements, dependent: :destroy
  has_many :ad_targetings, dependent: :destroy
  has_many :ad_targets, through: :ad_targetings
  has_and_belongs_to_many :industry_targets,
    class_name: "Category",
    foreign_key: "campaign_id",
    association_foreign_key: "category_id",
    join_table: "industry_targets_campaigns"
  has_and_belongs_to_many :job_target,
    class_name: "Category",
    foreign_key: "category_id",
    association_foreign_key: "campaign_id",
    join_table: "job_targets_campaigns"

  AUDIENCES = ["user", "business", "advertiser", "freelancer"]

  scope :by_audience, lambda {|a|
    joins(:ad_targets)
    .where(ad_targets: {audience: a})}
  scope :by_target, lambda {|t|
    joins(:ad_targets)
    .where(ad_targets: {name: t})}

  def toggle_status!
    return update_attribute(:active, false) if active?
    return update_attribute(:active, true) unless active?
  end
end
