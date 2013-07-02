class AddAdvertiserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :advertiser, :boolean, default: false
  end
end
