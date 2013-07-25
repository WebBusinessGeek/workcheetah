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
    yearly_compensation "26-35k"
  end

  factory :account do
    slug "test"
    name "test"
    role "CEO"
  end

  factory :block do
    blocker_id 1
    blocked_id 2
  end

  factory :advertiser, class: "User" do
    email { FactoryGirl.next(:email) }
    advertiser true
    password "password"
    password_confirmation "password"

      factory :advertiser_with_account do
        advertiser_account
      end
  end

  factory :advertiser_account do
    company "Ad Company"
    url "http://www.example.com"
    phone "5555555555"
    budget 0
    active false
  end


end