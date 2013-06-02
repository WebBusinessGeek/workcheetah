class Conversation < ActiveRecord::Base
  # Relations
  has_many :participants, dependent: :destroy
  has_many :conversation_items, dependent: :destroy
  accepts_nested_attributes_for :conversation_items

  attr_accessible :conversation_items_attributes
end
