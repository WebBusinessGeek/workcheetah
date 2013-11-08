class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :employee_id
      t.date :schedule_date
      t.datetime :start_hour
      t.datetime :end_hour
      t.integer :creator_id
      t.integer :shift_hours

      t.timestamps
    end
    add_index :shifts, :employee_id
    add_index :shifts, :schedule_date
    add_index :shifts, :creator_id
  end
end
