class Tweet < ActiveRecord::Base
  attr_accessible :body, :for_accounts, :for_public, :for_resumes, :subject

  validates :body, presence: true
end
