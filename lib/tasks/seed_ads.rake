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

  desc "Load Users with target_params lookup cache"
  task :load_user_targets => :environment do
    ActiveRecord::Base.transaction do
      User.all.each do |u|
        u.target_params = u.targeting_params
        u.save!
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

  desc "Utility task that converts old education table to new format (delete me when done)"
  task :convert_education => :environment do
    School.all.each do |s|
      puts "Before:"
      puts s.inspect
      s.completion_year = s.till.year unless s.till.nil?
      case s.degree_type
      when "Bachelors"
        s.highest_merit = School::HIGHEST_MERIT[7]
      when "Associates"
        s.highest_merit = School::HIGHEST_MERIT[5]
      when "Masters"
        s.highest_merit = School::HIGHEST_MERIT[9]
      when "Ph. D"
        s.highest_merit = School::HIGHEST_MERIT[10]
      else
        s.highest_merit = School::HIGHEST_MERIT[0]
      end
      s.save!
      puts "After:"
      puts s.inspect
    end
  end
end