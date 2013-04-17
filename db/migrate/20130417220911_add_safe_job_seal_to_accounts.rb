class AddSafeJobSealToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :safe_job_seal, :boolean, default: false
  end
end
