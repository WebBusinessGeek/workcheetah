if Rails.env.production?

  PIPELINE_ID = '1365380955979-de7855'

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_CARRIERWAVE_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_CARRIERWAVE_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = 'ladderpro'
    config.fog_public     = false
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.max_file_size     = 120.megabytes
  end

elsif Rails.env.development? || Rails.env.staging?

  PIPELINE_ID = '1365374876412-009ad6'

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_CARRIERWAVE_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_CARRIERWAVE_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = 'ladderdev'
    config.fog_public     = false
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.max_file_size     = 120.megabytes
  end

end
