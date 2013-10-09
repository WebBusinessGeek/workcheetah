class Estimate < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  PRICE = [[10, 500],[50, 2500],[175, 5000]]

  monetize :total_cents

  has_many :estimate_items, dependent: :destroy
  belongs_to :job
  belongs_to :sent_by, class_name: "Account", foreign_key: "account_id"

  accepts_nested_attributes_for :estimate_items
  state_machine initial: :drafting do
    event :send do
      transition :drafting => :reviewing
    end
    event :accept do
      transition :reviewing => :accepted
    end
    event :reject do
      transition :reviewing => :drafting
    end

    before_transition :drafting => :reviewing do |estimate|
      # mail estimate to job.account.user
    end
    after_transition :reviewing => :accepted do |estimate|
      #1 mail accepted to sent_by.account.user
      #2 mark job as working
      #3 create invoicable project
    end
  end

  def proposed_total
    estimate_items.sum(&:line_total) unless total
  end
end