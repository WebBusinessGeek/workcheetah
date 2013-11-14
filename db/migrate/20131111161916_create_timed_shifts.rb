class CreateTimedShifts < ActiveRecord::Migration
  def change
    create_table :timed_shifts do |t|
      t.references :user
      t.references :shift
      t.datetime, :start_time
      t.datetime, :end_time
      t.decimal :total_time, precision: 4, scale: 2

      t.timestamps
    end
    add_index :timed_shifts, :user_id
    add_index :timed_shifts, :shift_id
  end
end
