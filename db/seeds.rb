User.destroy_all
Resume.destroy_all
Account.destroy_all

Skill.destroy_all
SkillGroup.destroy_all
ActiveRecord::Base.transaction do
  Skill::GROUPED_SKILLS.each do |k,v|
    x = SkillGroup.create name: k
    v.each do |a|
      Skill.create name: a, skill_group_id: x.id
    end
  end
end

Category.destroy_all
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
   "computer programming", "writing / editing", "ETC"].each do |c|
      Category.create! name: c
    end
end

AdTarget.destroy_all
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

# sub the email addresses for anything you want for testing
[['employee','adam.robbie@gmail.com'],
['freelancer','adam.robbie@live.com'],
['business','adam.robbie@icloud.com']].each do |user_type|
  @user = User.create!(
    email: user_type.last,
    password: "testtest",
    password_confirmation: "testtest",
    role: user_type.first
  )
  case user_type.first
  when 'employee'
    @user.create_resume!(
      name: "Employee Test",
      phone: "321-262-8089",
      website: "http://www.employee.com",
      status: "unemployed",
      category1_id: 4,
      resume_type: user_type.first
    )
  when 'freelancer'
    @user.create_account!(
      name: "Freelancer Test",
      website: "http://www.freelancing.com",
      phone: "553-313-4424",
      slug: "test_freelancer",
      business_type: user_type.first,
    )
    @user.create_resume!(
      name: "Freelancer Test",
      phone: "553-313-4424",
      website: "http://www.freelancing.com",
      category1_id: 34,
      resume_type: user_type.first
    )
  when 'business'
    @user.create_account!(
      name: "Business Test Company",
      website: "http://www.company.com",
      phone: "999-555-3322",
      slug: "test_business",
      business_type: user_type.first,
    )
    @user.create_resume!(
      name: "Business Test Company",
      phone: "999-555-3322",
      website: "http://www.company.com",
      category1_id: 7,
      resume_type: user_type.first,
      status: "not blank anymore!"
    )
  else
  end
end
