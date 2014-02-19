class AddRateToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :rate, :integer
  end
end
