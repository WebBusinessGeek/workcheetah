class AddStatusToTimesheets < ActiveRecord::Migration
  def change
    remove_column :timesheet_entries, :status
    add_column :timesheets, :status, :string, default: "unpaid"
  end
end
