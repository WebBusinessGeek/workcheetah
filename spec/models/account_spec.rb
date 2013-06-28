require 'spec_helper'

describe Account do
	describe "Assocations" do
		[ :jobs, :users, :applicant_accesses, :payment_profiles, :seal_purchases ].each do |association_name|
			it { should have_many(association_name).dependent(:destroy) }
		end

		it { should have_many(:job_applications).through(:applicant_accesses) }

		it { should accept_nested_attributes_for :users }
	end

	describe "Basics" do
		context "Attributes" do
			[ "name", "website", "phone", "created_at", "updated_at", "credits", "logo", "slug", "safe_job_seal", "active", :role ].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			%w(has_credits? has_payment_profile? buy_applicant buy_seal).each do |method|
				it { should respond_to method }
			end
		end
	end

	describe "Validations" do
		before { FactoryGirl.create(:account) }
		it { should validate_uniqueness_of :slug }

		context "Inclusion" do
			it { should ensure_inclusion_of(:role).in_array([ "Hiring Manager", "CEO", "Business Owner", "Human Resource Manager", "Entrepreneur", "General Manager", "Independent Distributor", "Marketing Manager", "Sales Manager", "District Manager", "Regional Manager", "Account Executive", "Vice President", "President", "Director", "Partner" ]) }
		end

		context "Presence" do
			[ :name, :role, :slug ].each do |attr|
				it { should validate_presence_of attr }
			end
		end
	end
end
