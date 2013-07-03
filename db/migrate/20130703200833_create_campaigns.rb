class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :budget
      t.integer :advertiser_account_id

      t.timestamps
    end
  end
end
