class Staff < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :client, class_name: "User"
  belongs_to :staffer, class_name: "User"

  validates :client_id, presence: true
  validates :staffer_id, presence: true
  validates :staffer_id, uniqueness: {scope: [:client_id], message: "already belongs to client"}

end
