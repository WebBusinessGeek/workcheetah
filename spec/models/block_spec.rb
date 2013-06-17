require 'spec_helper'

describe Block do
	describe "Assoications" do
		it { should belong_to(:blocker).class_name("User") }
		it { should belong_to(:blocked_person).class_name("User") }
	end

  describe "Basics" do
  	describe "Attributes" do
  		[ :blocked_id, :blocker_id ].each do |attr|
  			it { should respond_to attr }
  			it { should allow_mass_assignment_of attr }
  		end
  	end
  end

  describe "Validations" do
  	[ :blocked_id, :blocker_id ].each do |attr|
  		it { should validate_presence_of attr }
  		it { should validate_numericality_of(attr).only_integer }
  		it { should_not allow_value(0).for(attr) }
  	end

    it "does not allow users to block themselves" do
      block = Block.new(blocker_id: 1, blocked_id: 1)
      block.should_not be_valid
      block.errors[:base].should include "You cannot block yourself."
    end
  end
end
