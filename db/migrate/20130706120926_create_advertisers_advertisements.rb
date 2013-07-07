class CreateAdvertisersAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisers_advertisements do |t|
      t.string :title, null: false
      t.string :url
      t.integer :campaign_id
      t.text :content
      t.date :start_time
      t.date :end_time
      t.integer :priority, default: 1
      t.boolean :confirmed, default: false
      t.integer :width
      t.integer :height
      t.attachment :image
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
