class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :user_id

  belongs_to :article
  belongs_to :user

  validates :article_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :body, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
