class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.references :job

      t.timestamps
    end
    add_index :questions, :job_id
  end
end
