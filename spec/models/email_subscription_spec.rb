require 'spec_helper'

describe EmailSubscription do
  describe "Assocations" do
		
	end

	describe "Basics" do
		context "Attributes" do
			[ :email, :location, :query ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		
	end
end
