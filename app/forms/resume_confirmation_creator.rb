class ResumeConfirmationCreator
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_reader :confirmation

  attribute :email, String
  attribute :message, String
  attribute :confirm_for, Integer
  attribute :reference, Integer

  validates :email, presence: true

  def save
    return false unless valid?
    delegates_attributes_to_confirmation
    if !errors.any?
      persist!
      true
    else
      false
    end
  end

  private
    def delegates_attributes_to_confirmation
      @confirmation = Reference.find(reference).build_confirmation do |c|
        c.email = email
        c.message = message
        c.confirm_for = confirm_for
      end
    end

    def generate_confirmation_token
      begin
        self.confirmation_token = SecureRandom.urlsafe_base64(4)
      end while self.class.exists?(confirmation_token: confirmation_token)
    end

    def persist!
      @confirmation.save!
    end
end