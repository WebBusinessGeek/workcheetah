class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    create_table :payment_profiles do |t|
      t.references :account
      t.string :stripe_customer_token
      t.string :nickname
      t.string :expiration
      t.string :cc_number_preview

      t.timestamps
    end
    add_index :payment_profiles, :account_id
  end
end
