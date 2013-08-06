require 'spec_helper'

describe BlogCategory do
	describe "Associations" do
		it { should have_many(:articles).dependent(:destroy) }
	end

	describe "Basics" do
		describe "Attributes" do
			[ :name ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end
	end

	describe "Validations" do
		describe "Presence" do
			[ :name ].each do |attr|
				it { should validate_presence_of attr }
			end
		end
	end
end
