class ChangeApplicantAccessToPolymorphic < ActiveRecord::Migration
  def up
    remove_column :applicant_accesses, :job_application_id
    add_column :applicant_accesses, :applicable_id, :integer
    add_column :applicant_accesses, :applicable_type, :string
    add_index :applicant_accesses, [:applicable_id, :applicable_type]
  end

  def down
    remove_index :applicant_accesses, [:applicable_id, :applicable_type]
    remove_column :applicant_accesses, :applicable_id
    remove_column :applicant_accesses, :applicable_type
    add_column :applicant_accesses, :job_application_id, :integer
  end
end
