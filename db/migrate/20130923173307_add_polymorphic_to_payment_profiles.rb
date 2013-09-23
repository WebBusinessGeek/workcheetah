class AddPolymorphicToPaymentProfiles < ActiveRecord::Migration
  def change
    remove_index :payment_profiles, :account_id
    remove_column :payment_profiles, :account_id
    add_column :payment_profiles, :accountable_id, :integer
    add_column :payment_profiles, :accountable_type, :string
    add_index :payment_profiles, [:accountable_id, :accountable_type]
  end
end
