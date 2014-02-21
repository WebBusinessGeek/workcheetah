class AddRatingToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :rating, :integer
    add_index :resumes, :rating
  end
end
