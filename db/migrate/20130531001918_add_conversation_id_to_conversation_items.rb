class AddConversationIdToConversationItems < ActiveRecord::Migration
  def change
    add_column :conversation_items, :conversation_id, :integer
  end
end
