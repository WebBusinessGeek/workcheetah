class ProjectsUser < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :user_id, uniqueness: { scope: [:project_id], message: "already exists in project" }
  validates :project, presence: true
end