class VideoChat < ActiveRecord::Base
  attr_accessible :accepted_by_recipient, :accepted_by_requester, :end_time, :note, :recipient_id, :requester_id, :start_time

  belongs_to :recipient, class_name: "User"
  belongs_to :requester, class_name: "User"
  has_many :video_chat_messages, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true

  after_create :creation_notification
  after_update :change_notification
  after_destroy :destruction_notification

  def creation_notification
  	self.notifications.create(body: "You have a new interview request.", user_id: self.recipient_id)
  end

  def change_notification
  	self.notifications.create(body: "Your interview has been updated.", user_id: self.recipient_id)
  	self.notifications.create(body: "Your interview has been updated.", user_id: self.requester_id)
  end

  def destruction_notification
  	Notification.create(body: "Your interview has been cancelled.", user_id: self.recipient_id)
  	Notification.create(body: "Your interview has been cancelled.", user_id: self.requester_id)
  end
end
