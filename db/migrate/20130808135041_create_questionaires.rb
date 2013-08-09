class CreateQuestionaires < ActiveRecord::Migration
  def change
    create_table :questionaires do |t|
      t.references :job

      t.timestamps
    end
    add_index :questionaires, :job_id
  end
end
