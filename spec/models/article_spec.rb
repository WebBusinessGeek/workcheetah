require 'spec_helper'

describe Article do
  describe "Assocations" do
		it { should have_many(:comments).dependent(:destroy) }
		it { should belong_to :blog_category }
	end

	describe "Basics" do
		context "Attributes" do
			[ :body, :cover, :slug, :subtitle, :title, :view_count ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		describe "Attachments" do
			it { should validate_attachment_content_type(:cover).allowing('image/png', 'image/jpg', 'image/jpeg') }
		end

		describe "Numericality" do
			it { should validate_numericality_of(:blog_category_id).only_integer }
			it { should allow_value(nil).for(:blog_category_id) }
			it { should_not allow_value(0).for(:blog_category_id) }
		end
	end
end
