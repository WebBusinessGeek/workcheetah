class CreateEmailSubscriptions < ActiveRecord::Migration
  def change
    create_table :email_subscriptions do |t|
      t.string :query
      t.string :location
      t.string :email

      t.timestamps
    end
  end
end
