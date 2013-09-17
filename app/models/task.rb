class Task < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :project
end
