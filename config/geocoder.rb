# config/initializers/geocoder.rb
Geocoder.configure(

  # geocoding service (see below for supported options):
  :lookup => :google,

  # to use an API key:
  :api_key => [ENV['GOOGLE_MAPS_API_KEY'], ENV['GOOGLE_MAPS_CLIENT_ID'], "channel"]

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  # :units => :km,

  # caching (see below for details):
  :cache => {},
  :cache_prefix => "..."

)