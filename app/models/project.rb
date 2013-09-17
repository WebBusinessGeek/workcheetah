class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :task
end
