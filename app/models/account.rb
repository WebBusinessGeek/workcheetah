class Account < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :jobs
  has_many :users
  has_many :applicant_accesses
  has_many :accessible_job_applications, through: :applicant_accesses
  has_many :payment_profiles

  validates_uniqueness_of :slug

  mount_uploader :logo, LogoUploader
  # attr_accessible :name, :phone, :website

  accepts_nested_attributes_for :users

  def has_credits?
    self.credits && self.credits > 0
  end

  def has_payment_profile?
    self.payment_profiles.any?
  end

  def buy_applicant(job_applicant)
    if has_payment_profile?
      @payment_profile = self.payment_profiles.first
      @payment_profile.stripe_customer_token
      @response = Stripe::Charge.create(
        :amount      => ApplicantAccess::PRICE_PER_APPLICANT,
        :currency    => "usd",
        :customer    => @payment_profile.stripe_customer_token,
        :description => "Charge for Job Applicant ##{job_applicant.id}")
      if @response.failure_message.nil?
        self.applicant_accesses.create(job_application: job_applicant)
      end
      @response
    end
    # self.applicant_accesses.create(job_application: job_applicant)
  end

  def buy_seal
    if has_payment_profile?
      @payment_profile = self.payment_profiles.first
      @response = Stripe::Charge.create(
        :amount      => 1995,
        :currency    => "usd",
        :customer    => @payment_profile.stripe_customer_token,
        :description => "Charge for Safe Job seal")
      if @response.failure_message.nil?
        self.update_attribute(:safe_job_seal, true)
      end
      @response
    end
    # self.update_attribute(:safe_job_seal, true)
  end
end
