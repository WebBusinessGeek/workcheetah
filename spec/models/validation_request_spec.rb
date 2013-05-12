require 'spec_helper'

describe ValidationRequest do
  describe "Assocations" do
		it { should belong_to :account }
	end

	describe "Basics" do
		context "Attributes" do
			[ :commission_only, :ein, :industry, :length_of_business, :name, :ssn ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		context "Presence" do
			[ :account_id, :commission_only, :ein, :name ].each do |attr|
				it { should validate_presence_of attr }
			end
		end

		context "Numericality" do
			it { should validate_numericality_of :account_id }
		end

		context "Format" do
			it { should validate_format_of(:ein).with(/\d{2}-\d{7}/) }
		end
	end
end
