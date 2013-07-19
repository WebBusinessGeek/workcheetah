class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.text :message
      t.string :email
      t.integer :confirm_for
      t.integer :confirm_by
      t.string :confirmation_token
      t.datetime :confirmation_sent
      t.datetime :confirmated_at
      t.integer :confirmable_id, polymorphic: true
      t.string :confirmable_type
      t.timestamps
    end
  end
end
