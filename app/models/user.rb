class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :job_applications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :scam_reports, dependent: :destroy
  has_one :resume, dependent: :destroy
  belongs_to :account
  has_one :advertiser_account
  has_many :requested_video_chats, class_name: "VideoChat", foreign_key: :requester_id, dependent: :destroy
  has_many :received_video_chats, class_name: "VideoChat", foreign_key: :recipient_id, dependent: :destroy
  has_many :video_chat_messages, foreign_key: :sender_id, dependent: :destroy
  has_many :participations, class_name: "Participant", dependent: :destroy
  has_many :conversations, through: :participations, dependent: :destroy
  has_many :conversation_items, through: :conversations, dependent: :destroy
  has_many :blocks, class_name: "Block", foreign_key: :blocker_id, dependent: :destroy
  has_many :blockings, class_name: "Block", foreign_key: :blocked_id, dependent: :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :terms_of_service, acceptance: true
  serialize :target_params
  
  def blocks? user
    self.blocks.where(blocked_id: user).any?
  end

  def has_applied_to?(job)
    self.job_applications.where(job_id: job.id).any?
  end

  def name
    if self.account
      self.account.name
    elsif self.resume
      self.resume.name
    end
  end

  def name=(name)
    if self.account
      self.account.update_attribute(:name, name)
    elsif self.resume
      self.resume.update_attribute(:name, name)
    end
  end

  def targeting_params
    params = []
    if moderator? or admin?
      params << "all"
    elsif advertiser?
      params << "advertiser"
    elsif account.present?
      params << "business"
      params << account.role unless account.role.nil?
    elsif resume.present?
      params << "user"
      params << resume.status unless resume.status.nil?
    else
      params << "all"
    end
    return params
  end
end
