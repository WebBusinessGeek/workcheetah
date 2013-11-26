class Estimate < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  PRICE = [[10, 500],[50, 2500],[175, 5000]]

  monetize :total_cents

  has_many :estimate_items, dependent: :destroy
  has_one :applicant_access, as: :applicable
  belongs_to :job
  belongs_to :sent_by, class_name: "Resume", foreign_key: "resume_id"
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :estimate_items, allow_destroy: true
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
    end
  end

  scope :sent, with_state("reviewing")
  scope :drafted, with_state("drafting")
  scope :rejected, with_state("rejected")

  def hire!(paytype)
    if paytype == "salary"
      create_applicant_access account: job.account, job: job, hourly: false
    else
      create_applicant_access account: job.account, job: job, hourly: true
    end
    job.account.owner.add_staffer!(sent_by.user)
    self.accept
    #3 Send Accepted Job Application mailer
    ids = job.recieved_estimate_ids - [self.id]
    Estimate.update_all({state: "rejected"}, {id: ids}) unless ids.empty?
    #4 Send mass rejection mailer for performance benefit
    @project = Project.create! title: job.title, job: job
    @project.update_attribute(owner_id: job.account.owner.id
    @project.users << @project.owner
    @project.users << sent_by.user
  end

  def proposed_total
    if total or total <= 0
      Money.new(estimate_items.sum(&:total_cents))
    else
      Money.new(total)
    end
  end

  def user
    sent_by.user
  end
end