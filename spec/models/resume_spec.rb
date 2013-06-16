require 'spec_helper'

describe Resume do
  describe "Assocations" do
		[ :addresses, :experiences, :invites, :schools, :references ].each do |association_name|
			it { should have_many(association_name).dependent(:destroy) }
		end

		[ :user, :category1, :category2, :category3 ].each do |association_name|
			it { should belong_to association_name }
		end

		[ :addresses, :schools, :references, :experiences, :user ].each do |association_name|
			it { should accept_nested_attributes_for association_name }
		end
	end

	describe "Basics" do
		context "Attributes" do
			[ :name, :phone, :email, :website, :twitter, :status, :category1_id, :category2_id, :category3_id ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end

			it { should respond_to :email_for_claim }
		end

		context "Methods" do
			[ :video_name, :enqueue_video, :invited_to_job? ].each do |method|
				it { should respond_to method }
			end
		end
	end

	describe "Validations" do
		context "Presence" do
			[ "name", "phone", "status", "category1_id" ].each do |attr|
				it { should validate_presence_of attr }
			end
		end

		context "Numericality" do
			[ :category1_id, :category2_id, :category3_id ].each do |attr|
				it { should validate_numericality_of(attr).only_integer }
			end

			[ :category2_id, :category3_id ].each do |attr|
				it { should allow_value(nil).for(attr) }
			end
		end
	end
end
