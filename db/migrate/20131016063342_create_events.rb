class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :start
      t.references :user

      t.timestamps
    end
  end
end
