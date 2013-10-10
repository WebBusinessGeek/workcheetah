class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :tasks
  has_many :users, through: :tasks
end
