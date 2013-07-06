class CreateAdvertiserAccounts < ActiveRecord::Migration
  def change
    create_table :advertiser_accounts do |t|
      t.string :company
      t.string :website
      t.string :phone
      t.integer :credits, default: 0
      t.boolean :active, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
