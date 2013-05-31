class Participant < ActiveRecord::Base
  attr_accessible :conversation_id, :user_id

  # Validations
  validates :conversation_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Relations
  belongs_to :user
  belongs_to :conversation
end
