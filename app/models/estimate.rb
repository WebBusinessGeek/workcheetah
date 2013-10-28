class Estimate < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  PRICE = [[10, 500],[50, 2500],[175, 5000]]

  monetize :total_cents

  has_many :estimate_items, dependent: :destroy
  has_one :applicant_access, as: :applicable
  belongs_to :job
  belongs_to :sent_by, class_name: "Resume", foreign_key: "resume_id"

  accepts_nested_attributes_for :estimate_items, allow_destroy: true
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
      estimate.create_applicant_access account: estimate.job.account, job: estimate.job
      estimate.job.account.owner.add_staffer!(estimate.sent_by.user)
      estimate.update_attribute(:state, "accepted")
      #3 Send Accepted Job Application mailer
      ids = estimate.job.recieved_estimates - [estimate]
      Estimate.update_all({state: "rejected"}, {id: ids}) unless ids.empty?
      #4 Send mass rejection mailer for performance benefit
      @project = Project.create! title: estimate.job.title
      @project.owner = estimate.job.account.owner
      @project.users << estimate.job.account.owner
      @project.users << estimate.sent_by.user
    end
  end

  alias_method :hire!, :accept
  scope :sent, with_state("reviewing")
  scope :drafted, with_state("drafting")
  scope :rejected, with_state("rejected")

  def proposed_total
    if total or total <= 0
      Money.new(estimate_items.sum(&:line_total))
    else
      Money.new(total)
    end
  end

  def user
    sent_by.user
  end
end