class AddRecipeientIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_recipient_id, :string
  end
end
