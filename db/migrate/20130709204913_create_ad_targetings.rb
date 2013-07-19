class CreateAdTargetings < ActiveRecord::Migration
  def change
    create_table :ad_targetings do |t|
      t.integer :ad_target_id
      t.integer :campaign_id

      t.timestamps
    end
  end
end
