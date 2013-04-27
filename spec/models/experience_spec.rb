require 'spec_helper'

describe Experience do
  describe "Assocations" do
		it { should belong_to :resume }
	end

	describe "Basics" do
		context "Attributes" do
			[ :company_name, :job_title, :from, :till, :highlights, :resume_id, :current_employer ].each do |attr|
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
