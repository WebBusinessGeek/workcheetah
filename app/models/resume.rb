require 'open-uri'

class Resume < ActiveRecord::Base
  # attr_accessible :distance_importance, :email, :freedom_importance, :growth_importance, :name, :pay_importance, :phone, :status, :website

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :schools, dependent: :destroy
  has_many :references, dependent: :destroy
  belongs_to :user

  mount_uploader :video, VideoUploader

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :schools
  accepts_nested_attributes_for :references
  accepts_nested_attributes_for :experiences

  after_save :enqueue_video

  def video_name
    File.basename(video.path || video.filename) unless video.blank?
  end

  def enqueue_video
    VideoWorker.perform(id, key) if key.present?
  end
end

require 'open-uri'

class VideoWorker
  WEB_MP4_PRESET_ID = '1351620000000-100070'

  def self.perform(id, key)
    resume = Resume.find(id)
    resume.key = key
    # resume.remote_video_url = resume.video.direct_fog_url(with_path: true)
    # resume.save!

    resume.update_column 'web_video',
      File.basename(resume.video.path)

    transcoder = AWS::ElasticTranscoder::Client.new
    transcoder.create_job(
      pipeline_id: PIPELINE_ID,
      input: {
        key: resume.video.path,
        frame_rate: 'auto',
        resolution: '640x360',
        aspect_ratio: 'auto',
        interlaced: 'auto',
        container: 'auto'
      },
      output: {
        key: resume.web_video,
        preset_id: WEB_MP4_PRESET_ID,
        thumbnail_pattern: "",
        rotate: '0'
      }
    )

  end
end