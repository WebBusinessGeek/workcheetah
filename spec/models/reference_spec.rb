require 'spec_helper'

describe Reference do
  describe "Assocations" do
		it { should belong_to :resume }
	end

	describe "Basics" do
		context "Attributes" do
			[ :name, :job_title, :company, :phone, :email, :notes, :reference_type, :resume_id ].each do |attr|
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
