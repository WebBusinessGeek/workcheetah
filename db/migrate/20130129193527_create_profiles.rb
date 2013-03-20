class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :website
      t.string :status
      t.string :growth_importance
      t.string :distance_importance
      t.string :freedom_importance
      t.string :pay_importance

      t.timestamps
    end
  end
end
