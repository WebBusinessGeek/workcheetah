class AddFieldsToSchool < ActiveRecord::Migration
  def up
    add_column :schools, :course_of_study, :string
    add_column :schools, :highest_merit, :string
    add_column :schools, :completion_year, :integer, limit: 4
  end

  def down
    remove_column :schools, :course_of_study
    remove_column :schools, :highest_merit
    remove_column :schools, :completion_year
  end
end
