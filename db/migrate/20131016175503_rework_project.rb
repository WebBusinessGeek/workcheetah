class ReworkProject < ActiveRecord::Migration
  def change
    remove_column :tasks, :user_id
    create_table :projects_users do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
  end
end
