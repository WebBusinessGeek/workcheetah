class AddCreditsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :credits, :integer
  end
end
