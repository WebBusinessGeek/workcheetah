class Resume < ActiveRecord::Base
  # after_save :enqueue_video
  after_save :update_rating

  attr_accessible :name, :phone, :email, :email_for_claim, :website, :twitter, :status,
    :addresses_attributes, :experiences_attributes, :schools_attributes, :references_attributes,
    :user_attributes, :category1_id, :category2_id, :category3_id, :skill_ids, :private, :resume_type
  TYPES = %w(employee freelancer business)
  attr_accessor :email_for_claim
  attr_accessor :employee_types

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :schools, dependent: :destroy
  has_many :references, dependent: :destroy
  belongs_to :user
  belongs_to :category1, class_name: "Category"
  belongs_to :category2, class_name: "Category"
  belongs_to :category3, class_name: "Category"
  has_and_belongs_to_many :skills
  has_one :confirmation, as: :confirmable, dependent: :destroy
  has_many :sent_estimates, class_name: "Estimate", foreign_key: "resume_id", dependent: :destroy


  mount_uploader :video, VideoUploader
  mount_uploader :web_video, VideoUploader

  accepts_nested_attributes_for :addresses, reject_if: proc { |attributes| attributes['address_1'].blank? }
  accepts_nested_attributes_for :schools, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :references, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :experiences, reject_if: proc { |attributes| attributes['company_name'].blank? || attributes['job_title'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :user

  validates :terms_of_service, acceptance: { accept: 1 }
  validates :name, presence: true
  validates :phone, presence: true
  validates :status, presence: true, :if => :business?
  validates :category1_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :category2_id, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :category3_id, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :resume_type, presence: true
  scope :ranked, -> {order("rating DESC")}

  def highest_merit_earned
    a = schools.pluck(:highest_merit).map {|x| School::HIGHEST_MERIT.rindex(x)}
    return School::HIGHEST_MERIT[a.max]
  end

  def invited_to_job?(job)
    Invite.where(resume_id: self, job_id: job).any?
  end

  def video_name
    File.basename(video.path || video.filename) unless video.blank?
  end

  def enqueue_video
    VideoWorker.perform(id, key) if key.present?
  end

  def enough_for_employers?
    name.present? and phone.present? and addresses.any? and category1_id.present?
  end

  def recommended
    [category1_id, category2_id, category3_id]
  end

  def update_rating
      update_column(:rating, Resumes::Rating.new(self).get_score)
  end

  def business?
    resume_type == 'business'
  end
end

# class VideoWorker
#   def self.perform(id, key)
#     raise
#     @resume = Resume.find(id)
#     @resume.update_column(:video, key)
#     @web_video_key = "resumes/#{@resume.id}/web_video/#{SecureRandom.hex(3)}-#{File.basename(@resume.key)}"
#     response = Zencoder::Job.create({
#       :input => @resume.video,
#       :output => {
#         :width => "480",
#         :url => "s3://ladderdev/" + @web_video_key,
#         :notification => "http://www.workcheetah.com/zencoder/response"
#       }
#     })
#     response
#     raise
#   end
# end

# require 'open-uri'

class VideoWorker
  WEB_MP4_PRESET_ID = '1365404213334-8f776a'
  GENERIC_360P_ID = "1351620000000-000040"

  def self.perform(id, key)
    @resume = Resume.find(id)
    @resume.update_column :web_video, nil
    @resume.update_column :video, nil
    @resume.update_column(:video, key.gsub("uploads/", ""))
    # raise
    # @resume.key = key
    # @resume.remote_video_url = resume.video.direct_fog_url(with_path: true)
    # @resume.save!
    # raise
    @web_video_key = "resumes/#{@resume.id}/web_video/#{SecureRandom.hex(3)}-#{File.basename(key)}"

    @resume.update_column 'web_video', @web_video_key

    transcoder = AWS::ElasticTranscoder::Client.new
    response = transcoder.create_job(
      pipeline_id: PIPELINE_ID,
      input: {
        key: @resume.video.path,
        frame_rate: 'auto',
        resolution: 'auto',
        aspect_ratio: 'auto',
        interlaced: 'auto',
        container: 'auto'
      },
      output: {
        key: @resume.web_video.path,
        preset_id: GENERIC_360P_ID,
        thumbnail_pattern: "",
        rotate: '0'
      }
    )
  end
end