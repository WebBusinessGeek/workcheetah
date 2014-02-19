class ShiftPayment < Payment
  has_many :shifts
  has_one :transfer_payment, class_name: "TransferPayment", foreign_key: "reference_id"
end