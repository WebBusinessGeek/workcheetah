class Block < ActiveRecord::Base
  attr_accessible :blocked_id, :blocker_id

  validates :blocked_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :blocker_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :blocker, class_name: "User"
  belongs_to :blocked_person, class_name: "User", foreign_key: :blocked_id
end
