class AddMetaToImage < ActiveRecord::Migration
  def change
    add_column :advertisements, :image_meta, :text
    remove_column :advertisements, :height
    remove_column :advertisements, :width
  end
end
