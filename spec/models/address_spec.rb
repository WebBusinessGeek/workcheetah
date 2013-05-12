require 'spec_helper'

describe Address do
  describe "Assocations" do
		it { should belong_to :addressable }
	end

	describe "Basics" do
		context "Attributes" do
			[ :address_1, :address_2, :addressable_id, :addressable_type, :city, :country_id, :latitude, :longitude, :state, :zip ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		context "Presence" do
			[ :address_1, :city, :state, :zip ].each do |attr|
				it { should validate_presence_of attr }
			end
		end

		context "Numericality" do
			it { should validate_numericality_of(:addressable_id).only_integer }
			it { should allow_value(nil).for(:addressable_id) }
		end
	end
end
