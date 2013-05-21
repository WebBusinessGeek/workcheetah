require 'spec_helper'

describe Tweet do
  describe "Assocations" do
		
	end

	describe "Basics" do
		context "Attributes" do
			[ :body, :for_accounts, :for_public, :for_resumes ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		it { should validate_presence_of :body }
	end
end
