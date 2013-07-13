class AdTargeting < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  belongs_to :ad_target
  belongs_to :campaign
end
