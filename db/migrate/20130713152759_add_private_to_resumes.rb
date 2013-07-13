class AddPrivateToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :private, :boolean, default: false
  end
end
