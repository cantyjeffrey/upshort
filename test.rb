#
# run tests
#
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require 'mocha/mini_test'
require 'rack/test'
require File.expand_path '../app.rb', __FILE__

# output
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# ye application
def app
  Sinatra::Application
end

# libs
include Rack::Test::Methods

# helpers
def login_user!
  post '/login', username: app.settings.username, password: app.settings.password
end
def logout_user!
  get '/logout'
end

# run all specs, if executed directly
if __FILE__ == $0
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end
