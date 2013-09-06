class Advertisement < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  AD_TYPES = %w(text image)
  belongs_to :campaign
  has_many :ad_stats, dependent: :destroy

  delegate :cpc?, :cpm?, to: :campaign

  has_attached_file :image,
    styles: { square: "250x250#", thumb: "100x100#", banner: "468x60#" },
    path: "advertising/:attachment/:id/:style.:extension",
    bucket: Figaro.env.aws_bucket

  def toggle!
    return update_attribute(:active, false) if active?
    return update_attribute(:active, true) unless active?
  end

  def total_impression_count
    ad_stats.sum(:impressions)
  end

  def total_click_count
    ad_stats.sum(:clicks)
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

  private
  def daily_reset
    update_attributes!(impression_count: 0, click_count: 0)
  end
end
