require 'spec_helper'

describe Invite do
	describe "Associations" do
		it { should belong_to :job }
		it { should belong_to :resume }
	end

  describe "Basics" do
  	describe "Attributes" do
  		[ :job_id, :resume_id ].each do |attr|
  			it { should respond_to attr }
  			it { should allow_mass_assignment_of attr }
  		end
  	end
  end

  describe "Validations" do
  	describe "Numericality" do
  		[ :job_id, :resume_id ].each do |attr|
  			it { should validate_numericality_of(attr).only_integer }
  			it { should_not allow_value(0).for(attr) }
  		end  		
  	end

  	describe "Presence" do
  		[ :job_id, :resume_id ].each do |attr|
  			it { should validate_presence_of attr }
  		end
  	end
  end
end
