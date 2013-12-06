# sub the email addresses for anything you want for testing
[['employee','adam.robbie@gmail.com'],
['freelancer','adam.robbie@live.com'],
['business','adam.robbie@icloud.com']].each do |user_type|
  @user = User.find_by_email(user_type.last)
  if @user
    @user.account.destroy
    @user.destroy
  end

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
      business_type: user_type.last,
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
      business_type: user_type.last,
    )
    @user.create_resume!(
      name: "Business Test Company",
      phone: "999-555-3322",
      website: "http://www.company.com",
      category1_id: 7,
      resume_type: user_type.first
    )
  else
  end
end