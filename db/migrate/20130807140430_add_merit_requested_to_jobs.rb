class AddMeritRequestedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :merit_requested, :string
  end
end
