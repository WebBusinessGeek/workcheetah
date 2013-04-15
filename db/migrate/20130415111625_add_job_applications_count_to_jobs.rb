class AddJobApplicationsCountToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :job_applications_count, :integer, :default => 0
    Job.reset_column_information
    Job.scoped.each do |j|
      Job.update_counters j.id, :job_applications_count => j.job_applications.count
    end
  end

  def down
    remove_column :jobs, :job_applications_count
  end
end
