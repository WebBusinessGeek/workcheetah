FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email { FactoryGirl.next(:email) }
    password "password"
    password_confirmation { password }
    # association :account
  end

  factory :job do
    sequence(:title){ |n| "Job Listing #{n}"}
    account_id 1
    category_id 1
    address "MyString"
    description "MyText"
    about_company "MyText"
  end

  factory :account do
    slug "test"
    name "test"
  end

  factory :block do
    blocker_id 1
    blocked_id 2
  end
end