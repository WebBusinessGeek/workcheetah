class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :company_name
      t.string :job_title
      t.date :from
      t.date :till
      t.text :highlights
      t.integer :profile_id

      t.timestamps
    end
  end
end
