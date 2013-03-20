class AddAccountIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :account_id, :integer
  end
end
