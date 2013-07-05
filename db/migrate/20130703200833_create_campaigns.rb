class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :budget
      t.integer :advertiser_account_id
      t.boolean :active, default: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
