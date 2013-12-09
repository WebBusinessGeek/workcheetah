class ChangeInviteOnlyOnJobs < ActiveRecord::Migration
  def up
    remove_column :jobs, :invite_only
    add_column :jobs, :invite_only, :boolean, default: false
  end

  def down
    remove_column :jobs, :invite_only
    add_column :jobs, :invite_only, :boolean, defalt: true
  end
end
