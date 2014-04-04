namespace :db do
  desc "Seeds Ad Target Data"
  task :seed_db do
    Rake::Task['db:load_targets'].invoke
    Rake::Task('db:load_categories').invoke
    Rake::Task('db:load_skills').invoke
  end

  desc "Loads default Ad Targets"
  task :load_targets => :environment do
    ActiveRecord::Base.transaction do
      puts "Loading User Target Words"
      AdTarget::AUDIENCES.each {|u| AdTarget.create(name: u, audience: "A")}
      Category.order(:name).pluck(:name).each do |u|
        AdTarget.create( name: u, audience: "B1")
        AdTarget.create( name: u, audience: "B2")
      end
      AdTarget::EMPLOYEE_TARGETS.each {|u| AdTarget.create(name: u, audience: "B3")}
      AdTarget::EDUCATION_TARGETS.each{|u| AdTarget.create(name: u, audience: "B4")}
      puts "Loading Advertiser Target Words"
      AdTarget::ADVERTISER_TARGETS.each {|a| AdTarget.create(name: a, audience: "B5")}
    end
  end

  desc "Load Users with target_params lookup cache"
  task :load_user_targets => :environment do
    ActiveRecord::Base.transaction do
      User.all.each do |u|
        u.target_params = u.targeting_params
        u.save!
      end
    end
  end

  desc "Load default categories"
  task :load_categories => :environment do
    ActiveRecord::Base.transaction do
      ["accounting / finance", "admin / office", "arch / engineering",
       "art / media / design", "biotech / science", "business / mgmt",
       "customer service", "education", "food / bev", "hospitality",
       "general labor", "government", "human resources", "internet engineers",
       "legal / paralegal", "manufacturing", "marketing", "public relations",
       "advertising", "medical / health", "nonprofits", "real estate",
       "retail", "wholesale", "sales", "business development", "salon / spa",
       "fitness", "freelance work", "security", "skilled trade / craft",
       "software / qa / dba", "systems / network", "tech support",
       "transport", "tv / film / media", "web design",
       "computer programming", "writing / editing", "ETC", "military", "law enforcement"].each do |c|
          Category.create! name: c
        end
    end
  end

  desc "Load skills data"
  task :load_skills => :environment do
    ActiveRecord::Base.transaction do
      Skill::GROUPED_SKILLS.each do |k,v|
        x = SkillGroup.create name: k
        v.each do |a|
          Skill.create name: a, skill_group_id: x.id
        end
      end
    end
  end
end
