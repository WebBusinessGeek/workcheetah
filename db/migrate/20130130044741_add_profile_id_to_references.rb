class AddProfileIdToReferences < ActiveRecord::Migration
  def change
    add_column :references, :profile_id, :integer
  end
end
