require 'spec_helper'

describe Category do
  describe "Assocations" do
		[ :jobs ].each do |association_name|
			it { should have_many association_name }
		end
	end

	describe "Basics" do
		context "Attributes" do
			it { should respond_to :name }
			it { should allow_mass_assignment_of :name }
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		
	end
end
