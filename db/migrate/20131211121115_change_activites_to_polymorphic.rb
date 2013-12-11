class ChangeActivitesToPolymorphic < ActiveRecord::Migration
  def up
    remove_column :activities, :job_id
    change_table :activities do |t|
      t.references :trackable, index: true, polymorphic: true
    end
  end

  def down
    add_column :activiites, :job_id
    change_table :activities do |t|
      t.remove_references :trackable, polymorphic: true
    end
  end
end
