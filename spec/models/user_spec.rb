require 'spec_helper'

describe User do
  describe "Assocations" do
		[ :job_applications, :scam_reports, :requested_video_chats, :received_video_chats, :video_chat_messages ].each do |association_name|
			it { should have_many(association_name).dependent(:destroy) }
		end

		it { should have_one(:resume).dependent(:destroy) }

		it { should belong_to :account }
	end

	describe "Authorization" do
		let(:admin) { Ability.new(User.new(admin: true)) }
		let(:normal_user) { Ability.new(User.new) }

		context "Tweets" do
			context "as admin" do
				subject { admin }
				it { should be_able_to :manage, Tweet }				
			end

			context "as normal user" do
				subject { normal_user }
				it { should_not be_able_to :manage, Tweet }
				it { should be_able_to :read, Tweet }
			end
		end
	end

	describe "Basics" do
		context "Attributes" do
			["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "sign_in_count", "current_sign_in_at", "last_sign_in_at", "current_sign_in_ip", "last_sign_in_ip", "created_at", "updated_at", "account_id", "admin", "moderator" ].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			[ :has_applied_to?, :name ].each do |method|
				it { should respond_to method }				
			end
		end
	end

	describe "Validations" do
		
	end
end
