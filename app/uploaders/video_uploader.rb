class VideoUploader < CarrierWave::Uploader::Base

  include CarrierWaveDirect::Uploader
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # include CarrierWave::MimeTypes
  # process :set_content_type

end
