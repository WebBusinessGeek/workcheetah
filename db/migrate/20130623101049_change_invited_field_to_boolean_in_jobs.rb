class ChangeInvitedFieldToBooleanInJobs < ActiveRecord::Migration
  def up
  	remove_column :jobs, :invited # in postgres, varchar fields cannot be changed to booleans directly
  	add_column :jobs, :invited, :boolean, default: :false
  end

  def down
  	remove_column :jobs, :invited # in postgres, boolean fields cannot be changed to varchars directly
  	add_column :jobs, :invited, :string
  end
end
