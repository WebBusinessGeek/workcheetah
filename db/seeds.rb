require "factory_girl"
require Rails.root.join("spec/factories.rb")

if Job.count == 0
  20.times{ FactoryGirl.create(:job) }
end

if CreditPackage.count == 0
  CreditPackage.create(name: "Singular", cost: 1.99, quantity: 1)
  CreditPackage.create(name: "Deca", cost: 9.99, quantity: 10)
  CreditPackage.create(name: "Profa", cost: 19.99, quantity: 50)
  CreditPackage.create(name: "Mega", cost: 34.99, quantity: 100)
end