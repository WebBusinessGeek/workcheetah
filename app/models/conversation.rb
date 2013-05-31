class Conversation < ActiveRecord::Base
  # Relations
  has_many :participants, dependent: :destroy
  has_many :conversation_items, dependent: :destroy
end
