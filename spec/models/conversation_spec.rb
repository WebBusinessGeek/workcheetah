require 'spec_helper'

describe Conversation do
	describe "Associations" do
		[ :participants, :conversation_items ].each do |assocations|
			it { should have_many assocations }
		end

		it { should accept_nested_attributes_for :conversation_items }
	end

	describe "Basics" do
		describe "Attributes" do
			[ :subject ].each do |attr|
				it { should respond_to attr }
			end
			
			[ :conversation_items_attributes, :subject ].each do |attr|
				it { should allow_mass_assignment_of :conversation_items_attributes }				
			end
		end
	end
end
