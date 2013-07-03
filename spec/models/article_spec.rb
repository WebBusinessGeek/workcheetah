require 'spec_helper'

describe Article do
  describe "Assocations" do
		
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
	end
end
