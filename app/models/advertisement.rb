class Advertisers::Advertisement < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
