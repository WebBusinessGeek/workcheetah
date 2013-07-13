class AddTargetParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :target_params, :text
  end
end
