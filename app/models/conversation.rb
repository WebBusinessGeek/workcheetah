class Conversation < ActiveRecord::Base
	attr_accessible :conversation_items_attributes, :subject
	
  # Relations
  has_many :participants, dependent: :destroy
  has_many :conversation_items, dependent: :destroy
  accepts_nested_attributes_for :conversation_items
end
