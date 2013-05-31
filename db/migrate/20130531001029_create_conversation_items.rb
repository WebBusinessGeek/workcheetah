class CreateConversationItems < ActiveRecord::Migration
  def change
    create_table :conversation_items do |t|
      t.text :body
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
