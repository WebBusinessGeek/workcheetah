class CreateScamReports < ActiveRecord::Migration
  def change
    create_table :scam_reports do |t|
      t.string :scammer_type
      t.string :name_used
      t.string :email_used
      t.string :reporter_ip
      t.integer :user_id
      t.string :phone_number_used
      t.text :any_additional_info

      t.timestamps
    end
  end
end
