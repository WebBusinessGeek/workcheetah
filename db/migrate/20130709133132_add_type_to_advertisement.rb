class AddTypeToAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :ad_type, :string
  end
end
