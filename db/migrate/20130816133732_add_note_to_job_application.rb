class AddNoteToJobApplication < ActiveRecord::Migration
  def change
    add_column :job_applications, :note, :string, default: "Have not spoken to"
  end
end
