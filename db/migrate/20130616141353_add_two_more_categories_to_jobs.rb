class AddTwoMoreCategoriesToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :category2_id, :integer
    add_column :jobs, :category3_id, :integer
  end
end
