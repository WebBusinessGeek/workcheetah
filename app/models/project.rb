class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :job
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :users
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
