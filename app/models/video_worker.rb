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
      pipeline_id: '1365370705143-671489',
      input: {
        key: resume.video.path,
        frame_rate: 'auto',
        resolution: 'auto',
        aspect_ratio: 'auto',
        interlaced: 'auto',
        container: 'auto'
      },
      output: {
        key: resume.web_video,
        preset_id: '1351620000000-100070',
        thumbnail_pattern: "",
        rotate: '0'
      }
    )
  end
end