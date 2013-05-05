class CreateSealPurchases < ActiveRecord::Migration
  def change
    create_table :seal_purchases do |t|
      t.integer :account_id
      t.integer :amount

      t.timestamps
    end
  end
end
