class AddPositionToTasksAndProjects < ActiveRecord::Migration
  def up
    add_column :projects_users, :position, :integer
    add_column :tasks, :position, :integer
    add_column :projects_users, :created_at, :datetime
    add_column :projects_users, :updated_at, :datetime

    execute "UPDATE projects_users SET position = id, created_at = now(), updated_at = now()"
    execute "UPDATE tasks SET position = id, created_at = now(), updated_at = now()"
  end

  def down
    remove_column :projects_user, :position
    remove_column :tasks, :position
    remove_column :projects_users, :created_at
    remove_column :projects_users, :updated_at
  end
end
