class Campaign < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertiser_account
  has_many :advertisements, dependent: :destroy
  has_many :image_ads, class_name: "ImageAd", conditions: {ad_type: "image"}
  has_many :text_ads, class_name: "TextAd", conditions: {ad_type: "text"}
  has_many :ad_targetings, dependent: :destroy
  # Whacky assocations to make forms work the Rails way as the client needs custom forms
  has_many :audience_targets, through: :ad_targetings,
                              class_name: "AdTarget",
                              source: :ad_target,
                              conditions: ["audience = ?", "A"]
  has_many :industry_targets, through: :ad_targetings,
                              class_name: "AdTarget",
                              source: :ad_target,
                              conditions: ["audience = ?", "B1"]
  has_many :job_targets, through: :ad_targetings,
                              class_name: "AdTarget",
                              source: :ad_target,
                              conditions: ["audience = ?", "B2"]
  has_many :employee_targets, through: :ad_targetings,
                              class_name: "AdTarget",
                              source: :ad_target,
                              conditions: ["audience = ?", "B3"]
  has_many :education_targets, through: :ad_targetings,
                              class_name: "AdTarget",
                              source: :ad_target,
                              conditions: ["audience = ?", "B4"]
  has_many :advertiser_targets, through: :ad_targetings,
                              class_name: "AdTarget",
                              source: :ad_target,
                              conditions: ["audience = ?", "B5"]

  accepts_nested_attributes_for :image_ads, allow_destroy: true
  accepts_nested_attributes_for :text_ads, allow_destroy: true
  accepts_nested_attributes_for :advertiser_account

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

  def cpm?
    return !cpc?
  end

  def audience
    ad_targets.by_audience("A")
  end
end
