class CreateValidationRequests < ActiveRecord::Migration
  def change
    create_table :validation_requests do |t|
      t.references :account
      t.string :name
      t.string :ein
      t.string :ssn
      t.string :industry
      t.string :length_of_business
      t.boolean :commission_only

      t.timestamps
    end
    add_index :validation_requests, :account_id
  end
end
