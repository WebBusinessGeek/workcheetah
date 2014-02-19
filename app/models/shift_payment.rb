class ShiftPayment < Payment
  has_many :shifts, class_name: "Shift", foreign_key: "payment_id"
  has_one :transfer_payment, class_name: "TransferPayment", foreign_key: "reference_id"
  belongs_to :account
  def self.add_payment(account_id, shifts = [])
    @payment = ShiftPayment.new
    @payment.account_id = account_id
    @payment.shifts << shifts
    @payment.amount = shifts.sum(&:value)
    @payment.save
    @payment
  end

  state_machine :status, initial: :pending do
    event :charge do
      transition [:errored, :pending] => :processing
    end
    event :success do
      transition :processing => :finished
    end
    event :failure do
      transition :processing => :errored
    end

    after_transition [:errored, :pending] => :processing do |payment|
      payment.charge_account
    end

    after_transition [:errored, :processing] => :finished do |payment|
      @transfer = payment.create_transfer_payment do |t|
        t.user_id = payment.shifts.first.employee_id
        t.amount = payment.amount
        t.transfer = true
      end
      @transfer.send_monies
    end
  end

    def charge_account
    begin
      save!
      charge = Stripe::Charge.create(
        amount: self.total,
        currency: "usd",
        customer: self.account.payment_profiles.first.stripe_customer_token,
        description: "Shift Payment Charge for #{self.amount} from #{self.account.owner.email}"
      )
      self.update_attributes(stripe_charge_id: charge.id, params: charge)
      self.success
    rescue Stripe::CardError => e
      self.update_attributes(params: e.message)
      self.failure
    rescue Stripe::InvalidRequestError => e
      self.update_attributes(params: e.message)
      self.failure
    end
  end
end