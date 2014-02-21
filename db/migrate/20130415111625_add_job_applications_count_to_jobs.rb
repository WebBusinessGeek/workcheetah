class AddJobApplicationsCountToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :job_applications_count, :integer, :default => 0
  end

  def down
    remove_column :jobs, :job_applications_count
  end
end
