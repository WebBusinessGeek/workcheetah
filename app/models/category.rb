class Category < ActiveRecord::Base
	attr_accessible :name
	
  has_many :jobs, dependent: :destroy
  has_many :resumes, dependent: :destroy
end
