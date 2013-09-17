class AddStateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :state, :string
    add_index :tasks, :state
  end
end
