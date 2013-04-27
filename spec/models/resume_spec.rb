require 'spec_helper'

describe Resume do
  describe "Assocations" do
		[ :addresses, :experiences, :schools, :references ].each do |association_name|
			it { should have_many(association_name).dependent(:destroy) }
		end

		[ :user, :category1, :category2, :category3 ].each do |association_name|
			it { should belong_to association_name }
		end
	end

	describe "Basics" do
		context "Attributes" do
			[ :name, :phone, :email, :website, :twitter, :status, :category1_id, :category2_id, :category3_id ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			[ :video_name, :enqueue_video ].each do |method|
				it { should respond_to method }
			end
		end
	end

	describe "Validations" do
		
	end
end
