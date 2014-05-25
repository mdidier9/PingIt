# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'capybara/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  #database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  #facebook oauth
  # config.include FacebookMacros
  OmniAuth.config.test_mode = true
    
  omniauth_hash = { 'uid' => '12345', 'nickname' => 'testuser', 'credentials' => { 'token' => 'umad', 'secret' => 'bro?' } }
    
  OmniAuth.config.add_mock(:twitter, omniauth_hash)
  OmniAuth.config.add_mock(:foursquare, omniauth_hash)
  OmniAuth.config.add_mock(:facebook, omniauth_hash.merge({'nickname' => 'Mr Herpy Derpy Pants'})) # Facebook has 'real-user' attributes, add them here if need be

  config.include OauthMocking

  #factory girl
  # config.include FactoryGirl::Syntax::Methods
  # config.before(:suite) do
  #   FactoryGirl.lint
  # end

  #capybara config
  config.include Capybara::DSL

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end
