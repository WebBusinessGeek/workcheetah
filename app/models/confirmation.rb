class Confirmation < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :confirmable, polymorphic: true
  belongs_to :confirmed_for, class_name: "User", foreign_key: "confirmed_for"
  belongs_to :confirmed_by, class_name: "User", foreign_key: "confirmed_by"

  before_create :generate_confirmation_token
  after_create :find_confirmable_by

  validate :reference_email_existance

  private
  def generate_confirmation_token
    begin
      self.confirmation_token = SecureRandom.urlsafe_base64(4)
    end while self.class.exists?(confirmation_token: confirmation_token)
  end

  def find_confirmable_by
    confirmed_by = User.where(email: confirmable.email).first
    unless confirmed_by
      user = User.new do |u|
        u.email = confirmable.email.downcase
        puts confirmation_token
        u.password = confirmation_token
        u.password_confirmation = confirmation_token
      end
      user.confirm!
      user.save!
      send_inapp_conversation(user.id, confirmable.resume.user_id)
      update_column(:confirmed_by, user.id)
    end
    #Send Confirmation email
  end

  def reference_email_existance
    errors.add(:confirmable,"Confirmation can't be sent for a reference without an email") if
    confirmable.email.blank?
  end
end
