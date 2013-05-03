class VideoChatMessage < ActiveRecord::Base
  attr_accessible :body, :sender_id, :video_chat_id

  belongs_to :sender, class_name: "User"
  belongs_to :video_chat

  validates :body, presence: true, length: { maximum: 10000 }
  validates :sender_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :video_chat_id, presence: true, numericality: { greater_than: 0, only_integer: true }
end
