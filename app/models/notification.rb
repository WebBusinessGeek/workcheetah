class Notification < ActiveRecord::Base
  attr_accessible :body, :notifiable_id, :notifiable_type, :user_id

  # Associations
  belongs_to :notifiable, polymorphic: true

  # Validations
  validates :body,				presence: true
  validates :notifiable_id, 	numericality: { only_integer: true, greater_than: 0 }, allow_blank: false
  validates :notifiable_type, 	presence: true
  validates :user_id, 			numericality: { only_integer: true, greater_than: 0 }, allow_blank: false
end
