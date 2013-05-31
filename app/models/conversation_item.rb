class ConversationItem < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :recipient_id, :sender_id

  # Relations
  belongs_to :conversation
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  # Validations
  validates :body, presence: true
  validates :conversation_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sender_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :recipient_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
