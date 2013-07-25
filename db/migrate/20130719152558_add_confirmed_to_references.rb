class AddConfirmedToReferences < ActiveRecord::Migration
  def change
    add_column :references, :confirmed, :boolean, default: false
  end
end
