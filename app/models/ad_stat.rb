class AdStat < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertisement
end
