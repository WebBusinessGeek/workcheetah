class AdStats < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :advertisement
end
