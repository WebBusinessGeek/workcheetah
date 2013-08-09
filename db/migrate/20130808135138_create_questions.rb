class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.references :questionaire

      t.timestamps
    end
    add_index :questions, :questionaire_id
  end
end
