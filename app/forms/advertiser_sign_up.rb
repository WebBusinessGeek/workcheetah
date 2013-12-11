class AdvertiserSignUp
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_reader :user

  attribute :email, String
  attribute :email_confirmation, String
  attribute :password, String
  attribute :password_confirmation, String

  validates :email, confirmation: true
  validates :password, confirmation: true
  validates :email, :email_confirmation, :password, :password_confirmation, presence: true

  def save
    return false unless valid?

    delegates_attributes_to_user

    delegates_errors_to_user unless @user.valid?

    if !errors.any?
      persist!
      true
    else
      false
    end
  end

  private
    def delegates_attributes_to_user
      @user = User.new do |user|
        user.email = email
        user.password = password
        user.password_confirmation = password
        user.advertiser = true
      end
    end

    def delegates_errors_to_user
      errors.add(:email, @user.errors[:email].first) if @user.errors[:email].present?
      errors.add(:email_confirmation, @user.errors[:email_confirmation].first) if @user.errors[:email_confirmation].present?
      errors.add(:password, @user.errors[:password].first) if @user.errors[:password].present?
      errors.add(:password_confirmation, @user.errors[:password_confirmation].first) if @user.errors[:password_confirmation].present?
    end

    def persist!
      # @user.confirm!
      @user.save!
      @user.create_advertiser_account!
    end
end