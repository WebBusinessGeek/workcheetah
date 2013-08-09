class Questionaire < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :job
  has_many :questions

  accepts_nested_attributes_for :questions
end
