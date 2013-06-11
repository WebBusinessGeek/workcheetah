class AddInviteOnlyToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :invite_only, :boolean
  end
end
