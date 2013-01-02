class AddSearchIndexToJobs < ActiveRecord::Migration
  def up
    execute "create index jobs_title on jobs using gin(to_tsvector('english', title))"
    execute "create index jobs_description on jobs using gin(to_tsvector('english', description))"
  end

  def down
    execute "drop index jobs_title"
    execute "drop index jobs_description"
  end
end
