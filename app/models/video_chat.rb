class VideoChat < ActiveRecord::Base
  attr_accessible :accepted_by_recipient, :accepted_by_requester, :end_time, :note, :recipient_id, :requester_id, :start_time

  belongs_to :recipient, class_name: "User"
  belongs_to :requester, class_name: "User"
  has_many :video_chat_messages, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
end
