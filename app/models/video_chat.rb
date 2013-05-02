class VideoChat < ActiveRecord::Base
  attr_accessible :accepted_by_recipient, :accepted_by_requester, :end_time, :recipient_id, :requester_id, :start_time

  belongs_to :recipient, class_name: "User"
  belongs_to :requester, class_name: "User"
end
