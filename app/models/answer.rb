class Answer < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :question
  belongs_to :user

  validates :question_id, uniqueness: {scope: :user_id}
end
