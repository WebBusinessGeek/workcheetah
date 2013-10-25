class AddJobAndOwnerToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :owner_id, :integer
    add_column :projects, :job_id, :integer
    add_index :projects, :owner_id
    add_index :projects, :job_id
  end
end
