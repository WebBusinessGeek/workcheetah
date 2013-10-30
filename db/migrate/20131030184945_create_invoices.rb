class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :project_id
      t.string :guid
      t.string :stripe_charge_id
      t.string :description
      t.string :error
      t.money :amount
      t.string :state

      t.timestamps
    end
  end
end
