class AddAttachmentCoverToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :articles, :cover
  end
end
