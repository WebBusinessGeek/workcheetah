class AddQuickApplicabilityToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :quick_applicable, :boolean, default: :true
    add_index :jobs, :quick_applicable
  end
end
