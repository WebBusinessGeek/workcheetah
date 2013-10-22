class AddDraftToConversations < ActiveRecord::Migration
  def change
    add_column :conversation_items, :draft, :boolean, default: false
  end
end
