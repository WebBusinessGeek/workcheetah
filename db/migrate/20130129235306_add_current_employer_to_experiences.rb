class AddCurrentEmployerToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :current_employer, :boolean
  end
end
