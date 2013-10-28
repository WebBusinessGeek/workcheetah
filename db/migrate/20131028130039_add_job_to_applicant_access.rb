class AddJobToApplicantAccess < ActiveRecord::Migration
  def change
    add_column :applicant_accesses, :job_id, :integer
  end
end
