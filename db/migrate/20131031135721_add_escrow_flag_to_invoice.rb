class AddEscrowFlagToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :escrow, :boolean, default: false
  end
end
