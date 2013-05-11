require 'spec_helper'

describe VideoChat do
  describe "Assocations" do
  	[ :recipient, :requester ].each do |association_name|
  		it { should belong_to association_name }
  	end

  	it { should have_many(:video_chat_messages).dependent(:destroy) }
	end

	describe "Basics" do
		context "Attributes" do
			[ :accepted_by_recipient, :accepted_by_requester, :note, :end_time, :recipient_id, :requester_id, :start_time ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		[ :start_time, :end_time ].each do |attr|
			it { should validate_presence_of attr }
		end
	end
end
