class CreateAdvertiserInvoices < ActiveRecord::Migration
  def change
    create_table :advertiser_invoices do |t|
      t.string :guid
      t.string :stripe_charge_id
      t.integer :advertiser_account_id
      t.money :amount
      t.string :description
      t.string :state
      t.string :error

      t.timestamps
    end
  end
end
