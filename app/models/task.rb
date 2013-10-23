  class Task < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :project

  scope :due, ->(date) { where(due_date: date) }
  scope :to_do, -> { with_state :to_do }
  scope :doing, -> { with_state :doing }
  scope :done, -> { with_state :done }

  state_machine initial: :to_do do
    event :start_task do
      transition :to_do => :doing
    end

    event :finish_task do
      transition :doing => :done
    end
  end
end
