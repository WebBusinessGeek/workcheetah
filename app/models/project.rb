class Project < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :job
  belongs_to :owner, class_name: "User"
  has_many :projects_users
  has_many :users, through: :projects_users, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
