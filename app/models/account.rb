class Account < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :jobs
  has_many :users
  has_many :applicant_accesses
  has_many :payment_profiles
  # attr_accessible :name, :phone, :website

  accepts_nested_attributes_for :users

  def has_credits?
    self.credits && self.credits > 0
  end

  def has_payment_profile?
    self.payment_profiles.active.any?
  end
end
