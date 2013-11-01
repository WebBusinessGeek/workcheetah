class CreateTimesheetEntries < ActiveRecord::Migration
  def change
    create_table :timesheet_entries do |t|
      t.references :timesheet
      t.date :date
      t.decimal :hours, precision: 3, scale: 1, default: 0
      t.string :note
      t.references :task
      t.string :status, default: "unpaid"

      t.timestamps
    end
    add_index :timesheet_entries, :timesheet_id
    add_index :timesheet_entries, :task_id
  end
end
