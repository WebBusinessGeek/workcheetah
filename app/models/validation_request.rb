class ValidationRequest < ActiveRecord::Base
  belongs_to :account
  attr_accessible :commission_only, :ein, :industry, :length_of_business, :name, :ssn
end
