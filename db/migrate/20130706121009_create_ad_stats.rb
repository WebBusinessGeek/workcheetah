class CreateAdStats < ActiveRecord::Migration
  def change
    create_table :ad_stats do |t|
      t.integer :advertisement_id
      t.integer :clicks, default: 0
      t.integer :impressions, default: 0

      t.timestamps
    end
  end
end
