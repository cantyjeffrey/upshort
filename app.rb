require 'sinatra'
require 'sinatra/config_file'
require 'haml'
require 'sinatra/reloader' if settings.development?
require 'pry' if settings.development? || settings.test?
app_root = File.expand_path('../', __FILE__)

# configuration
if File.exists? "#{app_root}/config.yml"
  config_file "#{app_root}/config.yml"
else
  raise "dude, where's my config.yml?" if settings.production?
  config_file "#{app_root}/config.yml.example"
end
set :sessions, key: settings.session_name, secret: settings.session_secret

# helpers
helpers do
  def logged_in?
    session[:username] == settings.username
  end
  def all_shorts
    Dir.glob("app_root/public/uploads/*.short.*")
  end
  def mk_rand
    chars = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    (0...settings.random_length).map { chars[rand(chars.length)] }.join
  end
  def get_shorter
    short = mk_rand
    tries = 0
    while all_shorts.include?(short)
      short = mk_rand
      tries += 1
      raise "this isn't random enough" if tries > settings.random_retries
    end
    short
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
  pass unless logged_in?
  #TODO: file upload
end
