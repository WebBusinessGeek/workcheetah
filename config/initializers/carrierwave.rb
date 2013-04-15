if Rails.env.production?

  PIPELINE_ID = '1365380955979-de7855'

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJMAFP7FPMMGMEOVA',                        # required
      :aws_secret_access_key  => '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',                        # required
      # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
      :host                   => 'https://#{fog_directory}.s3.amazonaws.com',             # optional, defaults to nil
      # :endpoint               => 'https://peacock_pro.s3-website-us-east-1.amazonaws.com' # optional, defaults to nil
    }
    config.fog_directory  = 'ladderpro'                     # required
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.max_file_size     = 120.megabytes
  end

  # CarrierWave.configure do |config|
  #   config.fog_credentials = {
  #     :provider               => 'AWS',       # required
  #     :aws_access_key_id      => 'AKIAJMAFP7FPMMGMEOVA',       # required
  #     :aws_secret_access_key  => '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'       # required
  #     # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  #   }
  #   config.fog_directory  = 'peacock_pro'                     # required
  #   config.fog_host       = 'https://s3.amazonaws.com'            # optional, defaults to nil
  #   config.fog_public     = false                                   # optional, defaults to true
  #   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  #   config.fog_authenticated_url_expiration = 86400
  #   config.cache_dir = "#{Rails.root}/tmp/uploads"
  # end

elsif Rails.env.development?

  PIPELINE_ID = '1365374876412-009ad6'

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJMAFP7FPMMGMEOVA',                        # required
      :aws_secret_access_key  => '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',                        # required
      # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
      :host                   => 'https://#{fog_directory}.s3.amazonaws.com',             # optional, defaults to nil
      # :endpoint               => 'https://peacock_dev.s3-website-us-east-1.amazonaws.com' # optional, defaults to nil
    }
    config.fog_directory  = 'ladderdev'                     # required
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.max_file_size     = 120.megabytes
  end



  # CarrierWave.configure do |config|
  #   config.fog_credentials = {
  #     :provider               => 'AWS',       # required
  #     :aws_access_key_id      => 'AKIAJMAFP7FPMMGMEOVA',       # required
  #     :aws_secret_access_key  => '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'       # required
  #     # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  #     :host                   => 's3.example.com',             # optional, defaults to nil
  #     :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  #   }
  #   config.fog_directory  = 'peacock_dev'                     # required
  #   # config.fog_host       = 'https://s3.amazonaws.com'            # optional, defaults to nil
  #   config.fog_public     = false                                   # optional, defaults to true
  #   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  # end

end