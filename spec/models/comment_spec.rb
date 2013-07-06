require 'spec_helper'

describe Comment do
	describe "Associations" do
		[ :user, :article ].each do |association|
			it { should belong_to association }
		end
	end

  describe "Basics" do
  	describe "Attributes" do
  		[ :article_id, :body, :user_id ].each do |attr|
  			it { should respond_to attr }
  			it { should allow_mass_assignment_of attr }
  		end
  	end
  end

  describe "Validations" do
  	describe "Numericality" do
  		[ :article_id, :user_id ].each do |attr|
  			it { should validate_numericality_of(attr).only_integer }
  			it { should_not allow_value(0).for(attr) }
  		end
  	end

  	describe "Presence" do
  		[ :article_id, :body, :user_id ].each do |attr|
  			it { should validate_presence_of attr }
  		end
  	end
  end
end
