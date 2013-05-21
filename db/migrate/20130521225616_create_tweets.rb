class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :body
      t.boolean :for_accounts
      t.boolean :for_public
      t.boolean :for_resumes

      t.timestamps
    end
  end
end
