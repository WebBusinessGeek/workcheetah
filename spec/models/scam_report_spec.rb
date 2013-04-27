require 'spec_helper'

describe ScamReport do
  describe "Assocations" do
		it { should belong_to :user }
	end

	describe "Basics" do
		context "Attributes" do
			[ :any_additional_info, :email_used, :name_used, :phone_number_used, :scammer_type ].each do |attr|
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
