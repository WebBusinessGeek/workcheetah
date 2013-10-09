class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :job_id
      t.integer :account_id
      t.text :terms
      t.text :notes
      t.string :state
      t.date :due_date
      t.date :start_date
      t.boolean :pre_fund
      t.money :total

      t.timestamps
    end
    add_index :estimates, :job_id
    add_index :estimates, :account_id
  end
end
