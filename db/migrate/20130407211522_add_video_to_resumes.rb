class AddVideoToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :web_video, :string
    add_column :resumes, :video, :string
  end
end
