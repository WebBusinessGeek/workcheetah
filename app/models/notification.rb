class Notification < ActiveRecord::Base
  attr_accessible :body, :notifiable_id, :notifiable_type, :user_id

  # Associations
  belongs_to :notifiable, polymorphic: true

  # Validations
  validates :body,				presence: true
  validates :notifiable_id, 	numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :user_id, 			numericality: { only_integer: true, greater_than: 0 }

  # Methods
  def has_notifiable?
  	self.notifiable_id.present? and self.notifiable_type.present?
  end
end
