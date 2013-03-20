class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :name
      t.string :job_title
      t.string :company
      t.string :phone
      t.string :email
      t.text :notes
      t.string :reference_type

      t.timestamps
    end
  end
end
