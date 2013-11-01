class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.references :project
      t.references :user

      t.timestamps
    end
    add_index :timesheets, :project_id
    add_index :timesheets, :user_id
  end
end
