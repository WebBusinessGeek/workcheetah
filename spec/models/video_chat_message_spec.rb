require 'spec_helper'

describe VideoChatMessage do
  describe "Assocations" do
  	[ :sender, :video_chat ].each do |association_name|
  		it { should belong_to association_name }
  	end
	end

	describe "Basics" do
		context "Attributes" do
			[ :body, :sender_id, :video_chat_id ].each do |attr|
				it { should respond_to attr }
				it { should allow_mass_assignment_of attr }
			end
		end

		context "Methods" do
			
		end
	end

	describe "Validations" do
		context "Length" do
			it { should ensure_length_of(:body).is_at_most(10000) }
		end

		context "Numericality" do
			[ :sender_id, :video_chat_id ].each do |attr|
				it { should validate_numericality_of(attr).only_integer }
				it { should_not allow_value(0).for(attr) }
				it { should_not allow_value(-1).for(attr) }
			end
		end

		context "Presence" do
			[ :body, :sender_id, :video_chat_id ].each do |attr|
				it { should validate_presence_of attr }
			end
		end
	end
end
