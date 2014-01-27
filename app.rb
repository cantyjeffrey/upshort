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
set :sessions, key: settings.session_name, secret: settings.session_secret

# helpers
helpers do
  def logged_in?
    session[:username] == settings.username
  end
end

# le routes
get '/' do
  haml (logged_in? ? :index : :login)
end

# authentication
post '/login' do
  pass if logged_in?
  uname = params[:username] || ''
  pword = params[:password] || ''
  if uname.empty? || pword.empty?
    status 400
    haml :login, locals: {error_msg: 'You must fill out all fields'}
  elsif uname != settings.username || pword != settings.password
    status 401
    haml :login, locals: {error_msg: 'Invalid username/password'}
  else
    session[:username] = uname
    redirect '/'
  end
end
get '/logout' do
  pass unless logged_in?
  session.delete(:username)
  redirect '/'
end

# uploading
get '/upload' do
  pass unless logged_in?
  haml :upload
end
post '/upload' do
  #TODO: file upload
end
