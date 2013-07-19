class CreateSkillGroups < ActiveRecord::Migration
  def change
    create_table :skill_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
