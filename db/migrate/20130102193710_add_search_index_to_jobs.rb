class AddSearchIndexToJobs < ActiveRecord::Migration
  def up
    execute "create index jobs_title on jobs using gin(to_tsvector('english', title))"
    execute "create index jobs_description on jobs using gin(to_tsvector('english', description))"
    execute "create index jobs_about_company on jobs using gin(to_tsvector('english', about_company))"
  end

  def down
    execute "drop index jobs_title"
    execute "drop index jobs_description"
    execute "drop index jobs_about_company"
  end
end
