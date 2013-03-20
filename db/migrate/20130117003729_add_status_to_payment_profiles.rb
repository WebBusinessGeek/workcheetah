class AddStatusToPaymentProfiles < ActiveRecord::Migration
  def change
    add_column :payment_profiles, :status, :string
  end
end
