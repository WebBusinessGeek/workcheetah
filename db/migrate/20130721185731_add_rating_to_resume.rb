class AddRatingToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :rating, :integer
    add_index :resumes, :rating

    Resume.all.each {|r| r.update_column(:rating, Resumes::Rating.new(r).get_score)}
  end
end
