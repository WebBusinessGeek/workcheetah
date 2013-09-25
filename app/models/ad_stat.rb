class AdStat < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertisement

  scope :unbilled, where(status: 'unbilled')
  scope :billed, where(status: 'billed')
end
