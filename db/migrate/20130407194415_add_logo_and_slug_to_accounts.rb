class AddLogoAndSlugToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :logo, :string
    add_column :accounts, :slug, :string
  end
end
