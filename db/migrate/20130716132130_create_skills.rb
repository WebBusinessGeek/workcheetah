class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :skill_group_id

      t.timestamps
    end
  end
end
