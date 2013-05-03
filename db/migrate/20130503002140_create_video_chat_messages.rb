class CreateVideoChatMessages < ActiveRecord::Migration
  def change
    create_table :video_chat_messages do |t|
      t.integer :video_chat_id
      t.integer :sender_id
      t.text :body

      t.timestamps
    end
  end
end
