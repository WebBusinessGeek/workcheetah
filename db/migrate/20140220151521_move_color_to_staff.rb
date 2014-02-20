class MoveColorToStaff < ActiveRecord::Migration
  def up
    remove_column :users, :color
    add_column :staffs, :color, :string, default: "#3a87ad"
  end

  def down
    remove_column :staffs, :color
    add_column :users, :color, :string, default: "#3a87ad"
  end
end
