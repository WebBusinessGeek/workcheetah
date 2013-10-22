class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :message
      t.references :user
      t.references :job

      t.timestamps
    end
  end
end
