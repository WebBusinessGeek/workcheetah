class CreateApplicantAccesses < ActiveRecord::Migration
  def change
    create_table :applicant_accesses do |t|
      t.references :job_application
      t.references :account

      t.timestamps
    end
    add_index :applicant_accesses, :job_application_id
    add_index :applicant_accesses, :account_id
  end
end
