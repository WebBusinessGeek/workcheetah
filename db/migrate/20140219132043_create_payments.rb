class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :type
      t.string :stripe_charge_id
      t.string :stripe_transfer_id
      t.integer :account_id
      t.integer :user_id
      t.boolean :transfer
      t.integer :amount
      t.string :status
      t.text :params
      t.integer :reference_id

      t.timestamps
    end
    add_index :payments, [:id, :type]
    add_index :payments, :account_id
    add_index :payments, :user_id
    add_index :payments, :reference_id
  end
end
