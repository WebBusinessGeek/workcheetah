class AddMaxBidToCampaign < ActiveRecord::Migration
  def change
    add_money :campaigns, :max_bid
    remove_column :campaigns, :budget
    add_money :campaigns, :budget
  end
end
