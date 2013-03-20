class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country_id
      t.float :latitude
      t.float :longitude
      t.string :addressable_type
      t.integer :addressable_id

      t.timestamps
    end
  end
end
