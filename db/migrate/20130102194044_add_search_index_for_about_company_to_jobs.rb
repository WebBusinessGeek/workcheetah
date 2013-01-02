class AddSearchIndexForAboutCompanyToJobs < ActiveRecord::Migration
  def up
    execute "create index jobs_about_company on jobs using gin(to_tsvector('english', about_company))"
  end

  def down
    execute "drop index jobs_about_company"
  end
end
