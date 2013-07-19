class CreateAdTargets < ActiveRecord::Migration
  def change
    create_table :ad_targets do |t|
      t.string :name
      t.string :audience

      t.timestamps
    end
  end
end
