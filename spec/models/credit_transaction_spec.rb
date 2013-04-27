require 'spec_helper'

describe CreditTransaction do
  describe "Assocations" do
		[ :account, :credit_package, :payment_profile ].each do |association_name|
			it { should belong_to association_name }
		end

		it { should accept_nested_attributes_for :payment_profile }
	end

	describe "Basics" do
		context "Attributes" do
			["id", "amount", "description", "quantity", "account_id", "credit_package_id", "payment_profile_id", "created_at", "updated_at"].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			[ :process_transaction, :charge_payment, :apply_credit, :update_attributes_to_match_credit_package ].each do |method|
				it { should respond_to method }
			end
		end
	end

	describe "Validations" do
		
	end
end
