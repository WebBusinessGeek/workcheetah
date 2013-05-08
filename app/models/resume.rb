class Resume < ActiveRecord::Base
  attr_accessible :name, :phone, :email, :email_for_claim, :website, :twitter, :status, :addresses_attributes, :experiences_attributes, :schools_attributes, :references_attributes, :user_attributes, :category1_id, :category2_id, :category3_id

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :schools, dependent: :destroy
  has_many :references, dependent: :destroy
  belongs_to :user
  belongs_to :category1, class_name: "Category"
  belongs_to :category2, class_name: "Category"
  belongs_to :category3, class_name: "Category"

  mount_uploader :video, VideoUploader
  mount_uploader :web_video, VideoUploader

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :schools
  accepts_nested_attributes_for :references
  accepts_nested_attributes_for :experiences
  accepts_nested_attributes_for :user

  attr_accessor :email_for_claim

  validates :terms_of_service, acceptance: { accept: 1 }

  # after_save :enqueue_video

  def video_name
    File.basename(video.path || video.filename) unless video.blank?
  end

  def enqueue_video
    VideoWorker.perform(id, key) if key.present?
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