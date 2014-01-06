class AddTransfersToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :stripe_transfer_id, :string
    add_column :invoices, :stripe_transfer_status, :string
  end
end
