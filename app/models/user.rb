class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :job_applications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :scam_reports, dependent: :destroy
  has_one :resume, dependent: :destroy
  belongs_to :account
  has_one :advertiser_account, dependent: :destroy
  has_many :requested_video_chats, class_name: "VideoChat", foreign_key: :requester_id, dependent: :destroy
  has_many :received_video_chats, class_name: "VideoChat", foreign_key: :recipient_id, dependent: :destroy
  has_many :video_chat_messages, foreign_key: :sender_id, dependent: :destroy
  has_many :participations, class_name: "Participant", dependent: :destroy
  has_many :conversations, through: :participations, dependent: :destroy
  has_many :conversation_items, through: :conversations, dependent: :destroy
  has_many :blocks, class_name: "Block", foreign_key: :blocker_id, dependent: :destroy
  has_many :blockings, class_name: "Block", foreign_key: :blocked_id, dependent: :destroy
  has_many :confirmed_references, class_name: "Confirmation", foreign_key: "confirm_for"
  has_many :confirmation_requests, class_name: "Confirmation", foreign_key: "confirm_by"
  has_many :notifications, dependent: :destroy
  has_many :questionaire_answers, class_name: "Answer"
  has_many :owned_projects, class_name: "Project", foreign_key: "owner_id", dependent: :destroy
  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users
  has_many :timesheets
  has_many :tasks, through: :projects
  has_many :events, dependent: :destroy
  has_many :activities, dependent: :destroy
  # Associations for staffing feature
  has_many :staffings, class_name: "Staff", foreign_key: "client_id", dependent: :destroy
  has_many :staffed_users, through: :staffings, source: :staffer
  # Associations for the contact/client feature
  has_many :reverse_staffings, foreign_key: "staffer_id",
                                   class_name:  "Staff",
                                   dependent:   :destroy
  has_many :clients, through: :reverse_staffings, source: :client

  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :terms_of_service, acceptance: true
  serialize :target_params

  after_create :generate_default_project

  def blocks? user
    self.blocks.where(blocked_id: user).any?
  end

  def has_applied_to?(job)
    self.job_applications.where(job_id: job.id).any?
  end

  def has_sent_estimate_to?(job)
    self.resume.sent_estimates.where(job_id: job.id).any?
  end

  def has_been_invited?(job)
    return false if !resume
    self.resume.invites.where(job_id: job.id).any?
  end

  def name
    # downcase role to normalize
    if ['freelancer', 'business'].include? role?
      @name = account.name if account.present?
    else
      @name = resume.name if resume.present?
    end
    @name
  end

  def name=(name)
    if self.role? == 'freelancer'
      # user = Freelancer.find_by_id(self.id)
      user.account.update_attribute(:name, name) if user.account.present?
    elsif self.role? == 'business'
      # user = Business.find_by_id(self.id)
      user.account.update_attribute(:name, name) if user.account.present?
    else
      self.resume.update_attribute(:name, name) if self.resume.present?
    end
  end

  def targeting_params
    params = []
    if advertiser?
      params << "advertiser"
    elsif role? == "business"
      params << "business"
    elsif role? == "freelancer"
      params << "freelancer"
      params << resume.status unless resume.status.nil?
    else role? == "employee"
      params << "employee"
      params << resume.status unless resume.status.nil?
    end
    params << "all"
    return params
  end

  def role?
    role
  end

  def default_project
    owned_projects.first
  end

  def add_task(task)
     default_project.tasks << task
  end

  def client_of?(user)
    reverse_staffings.where(client_id: user.id).any?
  end

  def add_staffer!(user)
    staffings.create!(staffer_id: user.id)
  end

  def remove_staffer!(user)
    staffings.find_by_staffer_id(user.id).destroy
  end

  private
    def generate_default_project
      unless default_project
        @project = Project.new title: "Default"
        self.owned_projects << @project
        self.projects << @project
      end
    end
end
