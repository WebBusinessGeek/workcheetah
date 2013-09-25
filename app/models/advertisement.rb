class Advertisement < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  # The priority column is unused atm but is a placeholder for future weighted ads system.
  AD_TYPES = %w(text image)
  belongs_to :campaign
  has_many :ad_stats, dependent: :destroy

  delegate :cpc?, :cpm?, to: :campaign

  scope :by_target, ->(t) {
    joins(campaign: [:ad_targets])
    .where(ad_targets: {name: t})
  }

  has_attached_file :image,
    styles: { sidebar: "110x70#", thumb: "75x75#", banner: "468x60#" },
    path: "advertising/:attachment/:id/:style.:extension",
    bucket: Figaro.env.aws_bucket

  def total_impression_count
    ad_stats.unbilled.sum(:impressions)
  end

  def total_click_count
    ad_stats.unbilled.sum(:clicks)
  end

  def generate_daily_stats
    return if !ad_stats.empty? && ad_stats.last.date == Date.today
    ad_stats.create clicks: click_count, impressions: impression_count, date: Date.today
    daily_reset
  end

  def stat_incrementor(type)
    # type: impression || click
    current = send("#{type}_count") || 0
    update_column("#{type}_count".to_sym, current + 1)
  end

  def self.batch_stat_incrementor(type, collection)
    Advertisement.update_all("#{type}_count = #{type}_count + 1", {id: collection})
  end

  private
  def daily_reset
    update_attributes!(impression_count: 0, click_count: 0)
  end
end
