class AddNotificationCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notifications_count, :integer, default: 0
    User.all.each do |user|
      User.reset_counters(user.id, :notifications)
    end
  end
end
