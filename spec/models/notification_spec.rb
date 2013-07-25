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
  		[ :has_notifiable? ].each do |method|
        it { should respond_to method }
      end
  	end
  end

  describe "Validations" do
  	describe "Numericality" do
  		[ :notifiable_id, :user_id ].each do |attr|
  			it { should validate_numericality_of(attr).only_integer }
  			it { should_not allow_value(0).for(attr) }
  		end

      it { should_not allow_value(nil).for(:user_id) }
  	end

  	describe "Presence" do
  		[ :body ].each do |attr|
  			it { should validate_presence_of attr }
  		end
  	end
  end
end
