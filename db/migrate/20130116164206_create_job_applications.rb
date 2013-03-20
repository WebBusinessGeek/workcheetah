class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.references :job
      t.references :user
      t.string :status

      t.timestamps
    end
    add_index :job_applications, :job_id
    add_index :job_applications, :user_id
  end
end
