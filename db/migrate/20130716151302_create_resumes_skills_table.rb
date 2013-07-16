class CreateResumesSkillsTable < ActiveRecord::Migration
  def up
    create_table :resumes_skills, :id => false do |t|
      t.references :resume
      t.references :skill
    end
  end

  def down
    drop_table :resumes_skills
  end
end
