class Advertisement < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  AD_TYPES = %w(text image)
  belongs_to :campaign
  has_one :ad_stat, dependent: :destroy

  has_attached_file :image,
    styles: { square: "250x250#", thumb: "100x100#", banner: "468x60#" },
    path: "advertising/:attachment/:id/:style.:extension",
    bucket: Figaro.env.aws_bucket

  def toggle!
    return update_attribute(:active, false) if active?
    return update_attribute(:active, true) unless active?
  end
end
