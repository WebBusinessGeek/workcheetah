class CreditPackage < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
