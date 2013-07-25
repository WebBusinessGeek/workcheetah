require 'spec_helper'

describe VideoChat do
  describe "Assocations" do
  	[ :recipient, :requester ].each do |association_name|
  		it { should belong_to association_name }
  	end

  	[ :notifications, :video_chat_messages ].each do |klasses|
  		it { should have_many(klasses).dependent(:destroy) }
  	end
	end

	describe "Basics" do
		context "Attributes" do
			[ :accepted_by_recipient, :accepted_by_requester, :note, :end_time, :recipient_id, :requester_id, :start_time ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			[ :change_notification, :creation_notification, :destruction_notification ].each do |method|
				it { should respond_to method }
			end
		end
	end

	describe "Validations" do
		[ :start_time, :end_time ].each do |attr|
			it { should validate_presence_of attr }
		end
	end
end
