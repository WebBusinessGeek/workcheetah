class AddDateToAdStats < ActiveRecord::Migration
  def change
    add_column :ad_stats, :date, :date
  end
end
