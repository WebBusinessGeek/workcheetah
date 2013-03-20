class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :degree_type
      t.string :degree_name
      t.date :from
      t.date :till
      t.boolean :currently_attending
      t.text :highlights
      t.integer :profile_id

      t.timestamps
    end
  end
end
