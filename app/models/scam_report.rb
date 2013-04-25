class ScamReport < ActiveRecord::Base
  attr_accessible :any_additional_info, :email_used, :name_used, :phone_number_used, :scammer_type

  belongs_to :user
end
