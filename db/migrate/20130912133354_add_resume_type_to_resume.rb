class AddResumeTypeToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :resume_type, :string
  end
end
