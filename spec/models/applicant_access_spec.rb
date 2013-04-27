require 'spec_helper'

describe ApplicantAccess do
  describe "Assocations" do
		[ :job_application, :account ].each do |association_name|
			it { should belong_to association_name }
		end
	end

	describe "Basics" do
		context "Attributes" do
			["id", "job_application_id", "account_id", "created_at", "updated_at"].each do |attr|
				it { should respond_to attr }
			end

			context "Constants" do
				specify { ApplicantAccess::PRICE_PER_APPLICANT.should be 99 }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		
	end
end
