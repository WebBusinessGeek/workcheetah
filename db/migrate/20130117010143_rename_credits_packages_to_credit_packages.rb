class RenameCreditsPackagesToCreditPackages < ActiveRecord::Migration
  def change
    rename_table :credits_packages, :credit_packages
  end
end
