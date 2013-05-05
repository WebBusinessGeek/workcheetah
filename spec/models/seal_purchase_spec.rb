require 'spec_helper'

describe SealPurchase do
  describe "Assocations" do
		it { should belong_to :account }
	end

	describe "Basics" do
		context "Attributes" do
			[ :account_id, :amount ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		[ :account_id, :amount ].each do |attr|
			it { should validate_presence_of attr }
			it { should validate_numericality_of attr }
		end
	end
end
