class AddDefaultsToDailyStatsCount < ActiveRecord::Migration
  def change
    change_column :advertisements, :impression_count, :integer, default: 0
    change_column :advertisements, :click_count, :integer, default: 0
  end
end
