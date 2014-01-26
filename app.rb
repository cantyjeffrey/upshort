require 'sinatra'
require 'sinatra/config_file'
if settings.development?
  require 'sinatra/reloader'
  require 'pry'
end

# configuration
if File.exists? './config.yml'
  config_file './config.yml'
else
  raise "dude, where's my config.yml?" if settings.production?
  config_file './config.yml.example'
end

get '/' do
  "Hello Worldy! #{settings.username}"
end
