class RenamePaymentMethodToPaymentProfileInCreditTransactions < ActiveRecord::Migration
  def change
    rename_column :credit_transactions, :payment_method_id, :payment_profile_id
  end
end
