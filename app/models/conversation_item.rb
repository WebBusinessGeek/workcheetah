class ConversationItem < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :recipient_id, :sender_id

  # Relations
  belongs_to :conversation
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  has_many :notifications, as: :notifiable, dependent: :destroy

  # Validations
  validates :body, presence: true
  validates :conversation_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sender_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  after_create :creation_notification

  def creation_notification
  	self.conversation.participants.where('user_id != ?', self.sender_id).each do |participant|
  		self.notifications.create(body: "You have a new message.", user_id: participant.user.id)
  	end
  end
end
