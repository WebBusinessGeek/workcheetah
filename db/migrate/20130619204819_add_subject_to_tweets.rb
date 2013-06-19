class AddSubjectToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :subject, :string
  end
end
