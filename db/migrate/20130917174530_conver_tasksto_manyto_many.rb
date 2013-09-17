class ConverTaskstoManytoMany < ActiveRecord::Migration
  def change
    remove_column :projects, :user_id
    add_column :tasks, :user_id, :integer
    add_index :tasks, :user_id
  end
end
