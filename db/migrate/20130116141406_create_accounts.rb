class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :website
      t.string :phone

      t.timestamps
    end
  end
end
