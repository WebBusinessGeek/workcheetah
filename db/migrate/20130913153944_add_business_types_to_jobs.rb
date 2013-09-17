class AddBusinessTypesToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_type, :string
    add_column :accounts, :business_type, :string
  end
end
