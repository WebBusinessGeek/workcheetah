class Advertisement < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
