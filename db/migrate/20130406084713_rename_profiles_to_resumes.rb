class RenameProfilesToResumes < ActiveRecord::Migration
  def change
    rename_table :profiles, :resumes
    rename_column :schools, :profile_id, :resume_id
    rename_column :references, :profile_id, :resume_id
    rename_column :experiences, :profile_id, :resume_id
  end

end
