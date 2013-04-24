class AddCategoryIdToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :category1_id, :integer
    add_column :resumes, :category2_id, :integer
    add_column :resumes, :category3_id, :integer
  end
end
