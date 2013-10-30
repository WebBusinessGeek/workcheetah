class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :invoice_id, index: true
      t.integer :task_id, index: true
      t.money :rate
      t.integer :hours
      t.string :note

      t.timestamps
    end
  end
end
