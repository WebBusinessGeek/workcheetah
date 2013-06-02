class RemoveRecipientIdFromConversationItems < ActiveRecord::Migration
  def up
    remove_column :conversation_items, :recipient_id
  end

  def down
    add_column :conversation_items, :recipient_id, :string
  end
end
