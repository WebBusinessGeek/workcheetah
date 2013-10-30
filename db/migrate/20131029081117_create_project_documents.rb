class CreateProjectDocuments < ActiveRecord::Migration
  def change
    create_table :project_documents do |t|
	  t.references :project
	  t.attachment :document
      t.timestamps
    end
  end
end
