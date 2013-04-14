class Resume < ActiveRecord::Base
  # attr_accessible :distance_importance, :email, :freedom_importance, :growth_importance, :name, :pay_importance, :phone, :status, :website

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :schools, dependent: :destroy
  has_many :references, dependent: :destroy
  belongs_to :user

  # mount_uploader :video, VideoUploader
  # mount_uploader :web_video, VideoUploader

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :schools
  accepts_nested_attributes_for :references
  accepts_nested_attributes_for :experiences
  accepts_nested_attributes_for :user

  # after_save :enqueue_video

  # def video_name
  #   File.basename(video.path || video.filename) unless video.blank?
  # end

  # def enqueue_video
  #   VideoWorker.perform(id, key) if key.present?
  # end
end

# require 'open-uri'

# class VideoWorker
#   WEB_MP4_PRESET_ID = '1365404213334-8f776a'

#   def self.perform(id, key)
#     @resume = Resume.find(id)
#     @resume.update_column :web_video, nil
#     @resume.update_column :video, nil
#     # raise
#     @resume.key = key
#     # resume.remote_video_url = resume.video.direct_fog_url(with_path: true)
#     # resume.save!
#     # raise
#     @web_video_key = "resumes/#{@resume.id}/web_video/#{SecureRandom.hex(3)}-#{File.basename(@resume.key)}"

#     @resume.update_column 'web_video', @web_video_key


#     transcoder = AWS::ElasticTranscoder::Client.new
#     transcoder.create_job(
#       pipeline_id: PIPELINE_ID,
#       input: {
#         key: @resume.key,
#         frame_rate: 'auto',
#         resolution: 'auto',
#         aspect_ratio: 'auto',
#         interlaced: 'auto',
#         container: 'auto'
#       },
#       output: {
#         key: "uploads/" + @resume.web_video.path,
#         preset_id: WEB_MP4_PRESET_ID,
#         thumbnail_pattern: "",
#         rotate: '0'
#       }
#     )

#   end
# end