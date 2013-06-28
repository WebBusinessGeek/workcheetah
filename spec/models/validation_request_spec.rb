require 'spec_helper'

describe ValidationRequest do
  describe "Assocations" do
		it { should belong_to :account }
		it { should have_one(:address).dependent(:destroy) }

		it { should accept_nested_attributes_for :address }
	end

	describe "Basics" do
		context "Attributes" do
			[ :commission_only, :contact_person, :contact_email, :contact_phone, :ein, :independent_distributorship_opportunity, :industry, :length_of_business, :name, :profit, :ssn ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end

			it { should allow_mass_assignment_of :address_attributes }
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		context "Presence" do
			[ :account_id, :contact_person, :contact_email, :name ].each do |attr|
				it { should validate_presence_of attr }
			end
		end

		context "Numericality" do
			it { should validate_numericality_of :account_id }
		end

		context "Format" do
			# it { should validate_format_of(:ein).with(/\d{2}-\d{7}/) }
			it { should allow_value("12-1234567").for(:ein) }
			it { should_not allow_value("mystring").for(:ein) }
			it { should allow_value(nil).for(:ein) }
			it { should_not allow_value("this is not an email address").for(:contact_email) }
			it { should allow_value("test@test.com").for(:contact_email) }
		end
	end
end
