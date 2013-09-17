class Account < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  ROLE_OPTIONS = [ "Hiring Manager", "CEO", "Business Owner", "Human Resource Manager", "Entrepreneur", "General Manager", "Independent Distributor", "Marketing Manager", "Sales Manager", "District Manager", "Regional Manager", "Account Executive", "Vice President", "President", "Director", "Partner" ]

  has_many :jobs, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :applicant_accesses, dependent: :destroy
  has_many :job_applications, through: :applicant_accesses
  has_many :payment_profiles, dependent: :destroy
  has_many :seal_purchases, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :role,
    inclusion: { in: ROLE_OPTIONS },
    on: :create

  mount_uploader :logo, LogoUploader

  accepts_nested_attributes_for :users

  def owner
    users.first
  end

  def has_credits?
    self.credits && self.credits > 0
  end

  def has_payment_profile?
    self.payment_profiles.any?
  end

  def buy_applicant(job_applicant)
    # if has_payment_profile?
    #   @payment_profile = self.payment_profiles.first
    #   @payment_profile.stripe_customer_token
    #   @response = Stripe::Charge.create(
    #     :amount      => ApplicantAccess::PRICE_PER_APPLICANT,
    #     :currency    => "usd",
    #     :customer    => @payment_profile.stripe_customer_token,
    #     :description => "Charge for Job Applicant ##{job_applicant.id}")
    #   if @response.failure_message.nil?
    #     self.applicant_accesses.create(job_application: job_applicant)
    #   end
    #   @response
    # end

    self.applicant_accesses.create(job_application: job_applicant)
    true # currently purchasing an applicant is free; if it shall not be free anymore, comment in above code and also inside job_applications_conroller#show
  end

  def buy_seal
    if has_payment_profile?
      @payment_profile = self.payment_profiles.first
      @response = Stripe::Charge.create(
        :amount      => PaymentProfile::SAFE_SEAL_PRICE,
        :currency    => "usd",
        :customer    => @payment_profile.stripe_customer_token,
        :description => "Charge for Safe Job seal"
      )
      if @response.failure_message.nil?
        self.update_attribute(:safe_job_seal, true)
        self.seal_purchases.create(amount: PaymentProfile::SAFE_SEAL_PRICE)
      end
      @response
    end
  end
end
