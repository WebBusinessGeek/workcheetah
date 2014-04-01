class AddEventableToEvents < ActiveRecord::Migration
  def change
    add_column :events, :eventable_id, :integer
    add_column :events, :eventable_type, :string
  end
end
