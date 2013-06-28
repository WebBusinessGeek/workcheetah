class AddRoleToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :role, :string
  end
end
