require 'spec_helper'

describe CreditPackage do
  describe "Assocations" do
		
	end

	describe "Basics" do
		context "Attributes" do
			[ :name, :cost, :quantity ].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		
	end
end
