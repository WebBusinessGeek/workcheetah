class AddCpcToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :cpc, :boolean, default: false
  end
end
