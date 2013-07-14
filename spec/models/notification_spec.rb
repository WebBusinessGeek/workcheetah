require 'spec_helper'

describe Notification do
	describe "Associations" do
		[ :notifiable, :user ].each do |klass|
			it { should belong_to klass }
		end
	end

  describe "Basics" do
  	describe "Attributes" do
  		[ :body, :notifiable_id, :notifiable_type, :user_id ].each do |attr|
  			it { should respond_to attr }
  			it { should allow_mass_assignment_of attr }
  		end  		
  	end

  	describe "Methods" do
  		
  	end
  end

  describe "Validations" do
  	describe "Numericality" do
  		[ :notifiable_id, :user_id ].each do |attr|
  			it { should validate_numericality_of(attr).only_integer }
  			it { should_not allow_value(nil).for(attr) }
  			it { should_not allow_value(0).for(attr) }
  		end
  	end

  	describe "Presence" do
  		[ :body, :notifiable_type ].each do |attr|
  			it { should validate_presence_of attr }
  		end
  	end
  end
end
