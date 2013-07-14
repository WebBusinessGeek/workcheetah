require 'spec_helper'

describe JobApplication do
  describe "Assocations" do
		[ :job, :user ].each do |association_name|
			it { should belong_to association_name }
		end

		[ :applicant_access, :notifications ].each do |klasses|
			it { should have_many(klasses).dependent(:destroy) }
		end
	end

	describe "Basics" do
		context "Attributes" do
			["id", "job_id", "user_id", "status", "created_at", "updated_at"].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			[ :reject!, :rejected? ].each do |method|
				it { should respond_to method }
			end
		end
	end

	describe "Validations" do
		
	end
end
