class AddNoteToVideoChats < ActiveRecord::Migration
  def change
    add_column :video_chats, :note, :text
  end
end
