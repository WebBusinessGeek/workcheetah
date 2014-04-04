class Confirmation < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  # include Rails.application.routes.url_helpers
  before_create :generate_confirmation_token

  belongs_to :confirmable, polymorphic: true
  belongs_to :confirm_for, class_name: "User", foreign_key: "confirm_for"
  belongs_to :confirm_by, class_name: "User", foreign_key: "confirm_by"

  validate :reference_email_existance
  validate :email, presence: true

  def send_email
    find_confirmable_by
    send_in_app_message
  end

  #TODO: move to DJ job struct
  def send_in_app_message
    @conversation = Conversation.create(subject: "Reference Confirmation Request")
    @message = @conversation.conversation_items.build
    @message.body = confirmation_message
    @message.sender = confirm_for
    if @message.save!
      @conversation.participants.create!(user_id: confirm_by.id)
      @conversation.participants.create!(user_id: confirm_for.id)
    else
      "Error"
    end
  end

  def confirmation_message
    "#{confirm_for.name} has requested a reference confirmation. Below is a summary of their work profile."
  end

  handle_asynchronously :send_email

  private
  def generate_confirmation_token
    begin
      self.confirmation_token = SecureRandom.urlsafe_base64(4)
    end while self.class.exists?(confirmation_token: confirmation_token)
  end

  def find_confirmable_by
    puts "confirmable"
    puts self.confirmable.inspect
    confirm_by = User.where(email: confirmable.email).pluck(:id).first
    unless confirm_by
      user = User.new do |u|
        u.email = confirmable.email.downcase
        u.password = confirmation_token
        u.password_confirmation = confirmation_token
        u.role = 'business'
      end
      puts user.inspect
      # user.confirm!
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
