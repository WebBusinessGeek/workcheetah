class AddRatingToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :rating, :integer
    add_index :jobs, :rating
    # Forgoing using this in migration, possibly add to rake task but ratings on jobs and resumes will need to be updated anyway by user 
    # probably don't even need the rake tasks due to the significatn changes on the jobs and resumes models.
    # Job.all.each {|r| r.update_column(:rating, Jobs::Rating.new(r).get_score)}
  end
end

