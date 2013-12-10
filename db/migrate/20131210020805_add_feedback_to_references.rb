class AddFeedbackToReferences < ActiveRecord::Migration
  def change
    add_column :references, :feedback, :text
  end
end
