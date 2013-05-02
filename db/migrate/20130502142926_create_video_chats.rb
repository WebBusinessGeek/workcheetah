class CreateVideoChats < ActiveRecord::Migration
  def change
    create_table :video_chats do |t|
      t.integer :requester_id
      t.integer :recipient_id
      t.boolean :accepted_by_requester
      t.boolean :accepted_by_recipient
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
