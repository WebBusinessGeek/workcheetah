class AddPaymentIdToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :payment_id, :integer
    add_index :shifts, :payment_id
  end
end
