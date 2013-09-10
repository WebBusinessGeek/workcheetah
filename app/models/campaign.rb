class Campaign < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  BASE = { cpc: 0.30, cpm: 0.05}
  AUDIENCE = {
    all: 0.09,
    employee: 0.12,
    freelancer: 0.14,
    business: 0.15,
    advertiser: 0.15
  }
  INDUSTRY = 0.08
  JOB = 0.08
  EMPLOYEE = 0.08
  EDUCATION = 0.07
  ADVERTISER = 0.08

  monetize :budget_cents, allow_nil: false
  monetize :max_bid_cents, allow_nil: false
    # numericality: { greater_than_or_equal_to: 5, message: "Max Bid must be greater than or equal to $0.05" }

  belongs_to :advertiser_account
  has_many :advertisements, dependent: :destroy
  has_many :image_ads, class_name: "ImageAd", conditions: {ad_type: "image"}
  has_many :text_ads, class_name: "TextAd", conditions: {ad_type: "text"}
  has_many :ad_targetings, dependent: :destroy
  # Whacky assocations to make forms work the Rails way as the client needs custom forms
  has_many :targets, through: :ad_targetings,
                    class_name: "AdTarget",
                    source: :ad_target
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

  validates :name, presence: true
  validate :validate_minimum_bid
  validates :audience_target_ids, numericality: {greater_than_or_equal_to: 1, message: "cannot be blank"}

  scope :by_audience, lambda {|a|
    joins(:audience_targets)
    .where(audience_targets: {audience: a})}
  scope :by_target, lambda {|t|
    joins(:targets)
    .where(targets: {name: t})}

  def target_audience
    targets.pluck(:name)
  end

  def daily_total_impressions
    advertisements.sum(:impression_count)
  end

  def daily_total_clicks
    advertisements.sum(:click_count)
  end

  def toggle_status!
    return update_attribute(:active, false) if active?
    return update_attribute(:active, true) unless active?
  end

  def cpm?
    return !cpc?
  end

  def minimumBid
    return Advertisers::CampaignBid.new(self).getPrice if max_bid.nil? || max_bid == 0
    return max_bid
  end

  private
    def validate_minimum_bid
      minimumBid = Advertisers::CampaignBid.new(self).getPrice
      if max_bid < minimumBid
        errors.add(:max_bid, " must be greater than or equal to $#{minimumBid}")
      end
      if budget < 25.00
        errors.add(:budget,  " must be greater than or equal to $25.00")
      end
    end
end
