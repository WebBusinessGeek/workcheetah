class AddDoneAndPositionToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :position, :integer
    add_column :todos, :done, :boolean, default: false
  end
end
