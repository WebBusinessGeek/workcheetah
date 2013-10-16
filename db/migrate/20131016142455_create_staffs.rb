class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :staffer_id
      t.integer :client_id

      t.timestamps
    end
  end
end
