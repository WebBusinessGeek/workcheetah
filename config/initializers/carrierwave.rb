if Rails.env.production?

  PIPELINE_ID = '1365380955979-de7855'

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAJMAFP7FPMMGMEOVA',
      :aws_secret_access_key  => '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',
    }
    config.fog_directory  = 'ladderpro'
    config.fog_public     = false
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.max_file_size     = 120.megabytes
    config.upload_expiration = 10.hours.from_now.utc
  end

elsif Rails.env.development?

  PIPELINE_ID = '1365374876412-009ad6'

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAJMAFP7FPMMGMEOVA',
      :aws_secret_access_key  => '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',
    }
    config.fog_directory  = 'ladderdev'
    config.fog_public     = false
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.max_file_size     = 120.megabytes
  end

end