class AddInviteOnlyToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :invite_only, :boolean, default: true
  end
end
