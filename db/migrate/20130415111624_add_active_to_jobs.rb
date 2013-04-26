class AddActiveToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :active, :boolean, default: true
    Job.update_all(active: true)

  end
end
