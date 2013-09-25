class AddStatusToAdStats < ActiveRecord::Migration
  def change
    add_column :ad_stats, :status, :string, default: "unbilled"
    remove_column :advertiser_accounts, :active
  end
end
