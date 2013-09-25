namespace :ads do
  desc "Seeds Ad Target Data"
  task :total_daily_stats => :environment do
    Campaign.where(active: true).each do |c|
      c.advertisements.each do |a|
        a.generate_daily_stats
      end
    end
  end
end