class Category < ActiveRecord::Base
	attr_accessible :name

  has_many :jobs
  has_many :resumes

  validates :name, presence: true
end
