class Confirmation < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :confirmable, polymorphic: true
  belongs_to :confirm_for, class_name: "User", foreign_key: "confirm_for"
  belongs_to :confirm_by, class_name: "User", foreign_key: "confirm_by"

  before_create :generate_confirmation_token

  validate :reference_email_existance
  validate :email, presence: true

  def send_email
    find_confirmable_by
  end

  handle_asynchronously :send_email
  private
  def generate_confirmation_token
    begin
      self.confirmation_token = SecureRandom.urlsafe_base64(4)
    end while self.class.exists?(confirmation_token: confirmation_token)
  end

  def find_confirmable_by
    confirm_by = User.where(email: confirmable.email).pluck(:id).first
    unless confirm_by
      user = User.new do |u|
        u.email = confirmable.email.downcase
        puts confirmation_token
        u.password = confirmation_token
        u.password_confirmation = confirmation_token
      end
      user.confirm!
      user.save!
      update_column(:confirm_by, user.id)
    else
      update_column(:confirm_by, confirm_by)
    end
  end

  def reference_email_existance
    errors.add(:email,"Confirmation can't be sent for a reference without an email") if
    confirmable.email.blank?
  end
end
