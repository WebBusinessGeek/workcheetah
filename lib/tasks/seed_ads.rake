namespace :db do
  desc "Seeds Ad Target Data"
  task :seed_ads do
    Rake::Task['db:load_targets'].invoke
  end

  desc "Loads default Ad Targets"
  task :load_targets => :environment do
    ActiveRecord::Base.transaction do
      puts "Loading User Target Words"
      AdTarget::USER_TARGETS.each {|u| AdTarget.create(name: u, audience: "user")}
      puts "Loading Business Target Words"
      AdTarget::BUSINESS_TARGETS.each {|b| AdTarget.create(name: b, audience: "business")}
      puts "Loading Advertiser Target Words"
      AdTarget::ADVERTISER_TARGETS.each {|a| AdTarget.create(name: a, audience: "advertiser")}
    end
  end
end