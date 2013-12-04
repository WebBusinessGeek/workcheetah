class AddRateToEstimateItems < ActiveRecord::Migration
  def change
    add_money :estimate_items, :rate
  end
end
