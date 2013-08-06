class CreateJobsSkillsTable < ActiveRecord::Migration
  def up
    create_table :jobs_skills, :id => false do |t|
      t.references :job
      t.references :skill
    end
  end

  def down
    drop_table :jobs_skills
  end
end

