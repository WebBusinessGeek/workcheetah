class AddYearlyCompensationToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :yearly_compensation, :string
  end
end
