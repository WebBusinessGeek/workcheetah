class ShiftPaymentForm
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :start_date, Date
  attribute :end_date, Date
  attribute :user_id, User
  attribute :biller_id, Account
  attribute :shifts, Array
  attribute :rate, Integer

  def initialize(options={})
    @user = User.find(options[:user_id])
    @biller = Account.find(options[:biller_id])
    @shifts = @user.scheduled_shifts.current_week
    @rate = @shifts.first.rate
  end

  def persisted?
    false
  end

  attr_reader :payment, :user, :biller

  def save
    return false unless valid?

    if !errors.any?
      persist!
      payment
    else
      false
    end
  end

  def display_amount
    "#{ApplicationController.helpers.number_to_currency(total_value / 100)}"
  end

  def display_time
    "#{total_time} hours"
  end

  def display_rate
    "#{ApplicationController.helpers.number_to_currency(rate / 100)}"
  end
  private
    def total_time
      @shifts.sum(&:logged_time)
    end

    def total_value
      @shifts.sum(&:value)
    end

    def persist!
      @payment = ShiftPayment.add_payment(@biller.id, @shifts)
    end

end
