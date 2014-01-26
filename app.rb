require 'sinatra'
require 'sinatra/config_file'
require 'haml'
require 'sinatra/reloader' if settings.development?
require 'pry' if settings.development? || settings.test?

# configuration
if File.exists? './config.yml'
  config_file './config.yml'
else
  raise "dude, where's my config.yml?" if settings.production?
  config_file './config.yml.example'
end
enable :sessions
set :session_secret, settings.session_secret

get '/' do
  haml :login
end
