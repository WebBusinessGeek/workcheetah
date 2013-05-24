class AddInvitedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :invited, :boolean, default: false
  end
end
