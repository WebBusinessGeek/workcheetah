require 'spec_helper'

describe ConversationItem do
  describe "Assocations" do
  	it { should belong_to :conversation }
  	it { should belong_to(:sender).class_name("User") }

    [ :notifications ].each do |klasses|
      it { should have_many(klasses).dependent(:destroy) }
    end
  end

  describe "Basics" do
  	describe "Attributes" do
  		[ :body, :conversation_id, :sender_id ].each do |attr|
  			it { should respond_to attr }
  			it { should allow_mass_assignment_of attr }
  		end
  	end

    describe "Methods" do
      [ :creation_notification ].each do |method|
        it { should respond_to method }
      end
    end
  end

  describe "Validations" do
  	describe "Numericality" do
  		[ :conversation_id, :sender_id ].each do |attr|
  			it { should validate_numericality_of attr }
  			it { should_not allow_value(0).for(attr) }
  		end
  	end

  	describe "Presence" do
  		[ :body, :conversation_id, :sender_id ].each do |attr|
				it { should validate_presence_of attr }
			end	
  	end
  end
end
