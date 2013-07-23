class AddJobsIndexes < ActiveRecord::Migration
  def change
    add_index :jobs, :account_id
    add_index :jobs, :active
  end
end
