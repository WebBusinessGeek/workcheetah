class AddCampaignIdToAdvertiserCharges < ActiveRecord::Migration
  def change
    add_column :advertiser_charges, :campaign_id, :integer
  end
end
