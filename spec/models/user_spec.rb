require 'spec_helper'

describe User do
  describe "Assocations" do
		[ :job_applications, :scam_reports ].each do |association_name|
			it { should have_many association_name }
		end

		it { should have_one :resume }

		it { should belong_to :account }
	end

	describe "Basics" do
		context "Attributes" do
			["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "sign_in_count", "current_sign_in_at", "last_sign_in_at", "current_sign_in_ip", "last_sign_in_ip", "created_at", "updated_at", "account_id", "admin"].each do |attr|
				it { should respond_to attr }
			end
		end

		context "Methods" do
			it { should respond_to :has_applied_to? }
		end
	end

	describe "Validations" do
		
	end
end
