class ProjectDocument < ActiveRecord::Base
  #include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :document, :project_id
  has_attached_file :document
  belongs_to :project
  
  validates_attachment_presence :document
end
