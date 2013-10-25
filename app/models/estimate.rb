class Estimate < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  PRICE = [[10, 500],[50, 2500],[175, 5000]]

  monetize :total_cents

  has_many :estimate_items, dependent: :destroy
  has_one :applicant_access, as: :applicable
  belongs_to :job
  belongs_to :sent_by, class_name: "Resume", foreign_key: "resume_id"

  accepts_nested_attributes_for :estimate_items
  state_machine initial: :drafting do
    event :send_proposal do
      transition :drafting => :reviewing
    end
    event :accept do
      transition :reviewing => :accepted
    end
    event :negotiate do
      transition :reviewing => :drafting
    end
    event :reject do
      transition :reviewing => :rejected
    end

    before_transition :drafting => :reviewing do |estimate|
      # mail estimate to sent_by.user
    end
    after_transition :reviewing => :rejected do |estimate|
      # mail rejection letter to sent_by.user
    end
    after_transition :reviewing => :accepted do |estimate|
      #1 mail accepted to sent_by.user
      create_applicant_access account: job.account
      self.update_attribute(:status, "Accepted")
      #3 Send Accepted Job Application mailer
      ids = job.recieved_estimates - [self]
      Estimate.update_all({state: "rejected"}, {id: ids}) unless ids.empty?
      #4 Send mass rejection mailer for performance benefit
      #5 create project workspace for the job
    end
  end

  scope :sent, with_state("reviewing")
  scope :drafted, with_state("drafting")
  scope :rejected, with_state("rejected")

  def proposed_total
    unless total or total <= 0
      estimate_items.sum(&:line_total)
    else
      total
    end
  end
end