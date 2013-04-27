require 'spec_helper'

describe PaymentProfile do
  describe "Assocations" do
		it { should belong_to :account }
	end

	describe "Basics" do
		context "Attributes" do
			["id", "account_id", "stripe_customer_token", "nickname", "expiration", "cc_number_preview", "created_at", "updated_at", "status", "stripe_card_token", "product" , "first_job_applicant_to_buy"].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			it { should respond_to :get_stripe_customer_token }
		end
	end

	describe "Validations" do
		
	end
end
