class AddIndustryToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :industry, :string
  end
end
