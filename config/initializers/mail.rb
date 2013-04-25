ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

if Rails.env.development?
  ActionMailer::Base.default_url_options = {:host => "localhost:3000"}
elsif Rails.env.production?
  ActionMailer::Base.default_url_options = {:host => "www.workcheetah.com"}
end