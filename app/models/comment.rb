class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :body, :user_id

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :body, :commentable_type, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
