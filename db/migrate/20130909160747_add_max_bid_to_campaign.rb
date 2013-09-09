class AddMaxBidToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :max_bid, :integer
  end
end
