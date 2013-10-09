class CreateEstimateItems < ActiveRecord::Migration
  def change
    create_table :estimate_items do |t|
      t.references :estimate
      t.string :task
      t.integer :hours
      t.money :total

      t.timestamps
    end
    add_index :estimate_items, :estimate_id
  end
end
