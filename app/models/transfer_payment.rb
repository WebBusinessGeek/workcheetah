class TransferPayment < Payment
  TRANSFER_FEE = 25
  belongs_to :user
  belongs_to :shift_payment, foreign_key: "reference_id"

  state_machine :status, initial: :pending do
    event :send_monies do
      transition [:errored, :pending] => :processing
    end
    event :success do
      transition :processing => :finished
    end
    event :failure do
      transition :processing => :errored
    end

    after_transition [:errored, :pending] => :processing do |transfer|
      transfer.transfer_money
    end
  end

  def transfer_money
    begin
      save!
      transfer = Stripe::Transfer.create(
        amount: self.total,
        currency: "usd",
        recipient: self.user.stripe_recipient_id,
        statement_descriptor: "Transfer of #{self.amount} from #{self.shift_payment.account.owner.email}"
      )
      self.update_attributes(stripe_transfer_id: transfer.id, params: transfer)
      self.success
    rescue Stripe::InvalidRequestError => e
      self.update_attributes(params: e.message)
      self.failure
    end
  end

  def total
    (self.shift_payment.amount + TRANSFER_FEE)
  end
end