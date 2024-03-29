ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
Capybara.javascript_driver = :webkit

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Paperclip (more inside config block)
require "paperclip/matchers"

# Cancan
require "cancan/matchers"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Paperclip
  config.include Paperclip::Shoulda::Matchers
  config.include Capybara::DSL

  # Devise
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :view
end