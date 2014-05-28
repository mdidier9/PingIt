# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Ping::Application.initialize!

Ping::Application.configure do
  config.gem 'redis'
end
