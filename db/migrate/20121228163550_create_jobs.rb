class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :about_company
      t.boolean :active

      t.timestamps
    end
  end
end
