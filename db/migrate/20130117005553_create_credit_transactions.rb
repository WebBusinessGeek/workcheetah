class CreateCreditTransactions < ActiveRecord::Migration
  def change
    create_table :credit_transactions do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :description
      t.integer :quantity
      t.references :account
      t.references :credit_package
      t.references :payment_method

      t.timestamps
    end
    add_index :credit_transactions, :account_id
    add_index :credit_transactions, :credit_package_id
    add_index :credit_transactions, :payment_method_id
  end
end
