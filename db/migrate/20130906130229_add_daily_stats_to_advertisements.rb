class AddDailyStatsToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :impression_count, :integer
    add_column :advertisements, :click_count, :integer
  end
end
