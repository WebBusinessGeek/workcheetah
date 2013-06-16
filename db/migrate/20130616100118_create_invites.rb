class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :job_id
      t.integer :resume_id

      t.timestamps
    end
  end
end
