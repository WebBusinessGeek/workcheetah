class Tweet < ActiveRecord::Base
  attr_accessible :body, :for_accounts, :for_public, :for_resumes

  validates :body, presence: true
end
