require 'spec_helper'

describe Job do
  describe "Assocations" do
		[ :account ].each do |association_name|
			it { should belong_to association_name }
		end

		[ :category1, :category2, :category3 ].each do |association_name| # test both category and category1! both names are used in the code for backwards compatibility reasons
			it { should belong_to(association_name).class_name("Category") }
		end

		it { should belong_to :category } # test both category and category1! both names are used in the code for backwards compatibility reasons

		[ :invites, :job_applications, :notifications ].each do |klasses|
			it { should have_many(:job_applications).dependent(:destroy) }
			it { should have_many(:invites).dependent(:destroy) }
			it { should have_many(klasses).dependent(:destroy) }			
		end

		it { should accept_nested_attributes_for :account }
	end

	describe "Basics" do
		context "Attributes" do
			["id", "invite_only", "quick_applicable", "title", "description", "about_company", "created_at", "updated_at", "account_id", "latitude", "longitude", "address", "active", "job_applications_count", "category1_id", "category2_id", "category3_id", "invited"].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do

		end
	end

	describe "Validations" do
		context "Inclusion" do
			it { should ensure_inclusion_of(:yearly_compensation).in_array([ "15-25k",  "26-35k",  "36-45k",  "46-55k",  "66-75k",  "76-85k",  "86-95k",  "96k+",  "commission based",  "salary + commission",  "undisclosed" ]) }
		end

		context "Numericality" do
			[ :account_id, :category_id ].each do |attr|
				it { should validate_numericality_of(attr).only_integer }				
			end

			it { should allow_value(nil).for(:account_id) }

			[ :category2_id, :category3_id ].each do |attr|
				it { should validate_numericality_of(attr).only_integer }
				it { should allow_value(nil).for(attr) }
			end
		end

		context "Presence" do
			[ :title, :address, :category_id ].each do |attr|
				it { should validate_presence_of attr }
			end
		end
	end
end
