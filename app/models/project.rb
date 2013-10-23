class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_and_belongs_to_many :users
  has_many :tasks
  has_many :comments, as: :commentable
end
