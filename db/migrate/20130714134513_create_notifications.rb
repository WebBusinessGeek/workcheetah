class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text :body
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps
    end
  end
end
