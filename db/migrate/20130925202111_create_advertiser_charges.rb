class CreateAdvertiserCharges < ActiveRecord::Migration
  def change
    create_table :advertiser_charges do |t|
      t.integer :advertiser_invoice_id
      t.money :amount
      t.string :description
      t.integer :quantity
      t.timestamps
    end
  end
end
