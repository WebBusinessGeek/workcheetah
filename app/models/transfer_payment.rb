class TransferPayment < Payment
  belongs_to :user
  belongs_to :shift_payment
end