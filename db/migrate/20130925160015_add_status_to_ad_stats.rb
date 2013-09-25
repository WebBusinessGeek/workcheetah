class AddStatusToAdStats < ActiveRecord::Migration
  def change
    add_column :ad_stats, :status, :string, default: "unbilled"
  end
end
