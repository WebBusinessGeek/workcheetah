class CreateCreditsPackages < ActiveRecord::Migration
  def change
    create_table :credits_packages do |t|
      t.string :name
      t.decimal :cost, :precision => 6, :scale => 2
      t.integer :quantity
      t.timestamps
    end
  end
end
