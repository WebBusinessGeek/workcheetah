require 'spec_helper'

describe Job do
  describe "Assocations" do
		[ :account, :category ].each do |association_name|
			it { should belong_to association_name }
		end

		it { should have_many(:job_applications).dependent(:destroy) }

		it { should accept_nested_attributes_for :account }
	end

	describe "Basics" do
		context "Attributes" do
			["id", "title", "description", "about_company", "created_at", "updated_at", "account_id", "latitude", "longitude", "address", "active", "job_applications_count", "category_id"].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do

		end
	end

	describe "Validations" do
		
	end
end
