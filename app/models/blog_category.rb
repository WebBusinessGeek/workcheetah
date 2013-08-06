class BlogCategory < ActiveRecord::Base
  attr_accessible :name
  
  has_many :articles, dependent: :destroy

  validates :name, presence: true
end
