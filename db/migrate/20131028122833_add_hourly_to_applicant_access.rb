class AddHourlyToApplicantAccess < ActiveRecord::Migration
  def change
    add_column :applicant_accesses, :hourly, :boolean, default: :true
  end
end
