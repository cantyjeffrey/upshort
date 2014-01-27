require File.expand_path '../../test.rb', __FILE__

describe 'GET login' do
  it 'shows the login page' do
    get '/'
    assert last_response.ok?
    assert last_response.body.include? 'Please Login'
  end
end

describe 'POST login' do
  it 'requires username' do
    post '/login', password: 'blah'
    assert last_response.bad_request?
    assert last_response.body.include? 'fill out all fields'
  end
  it 'requires password' do
    post '/login', username: 'blah'
    assert last_response.bad_request?
    assert last_response.body.include? 'fill out all fields'
  end
  it 'fails invalid usernames/passwords' do
    post '/login', username: 'blah', password: 'blah'
    assert_equal last_response.status, 401
    assert last_response.body.include? 'Invalid username/password'
  end
  it 'logs in with correct username/password' do
    post '/login', username: app.settings.username, password: app.settings.password
    assert last_response.redirect?
  end
  it 'does not exist when already logged in' do
    post '/login'
    refute last_response.not_found?
    login_user!
    post '/login'
    assert last_response.not_found?
  end
end

describe 'GET logout' do
  it 'logs out the user' do
    login_user!
    get '/'
    refute last_response.body.include? 'Please Login'
    get '/logout'
    assert last_response.redirect?
    get '/'
    assert last_response.body.include? 'Please Login'
  end
  it 'does not exist when already logged out' do
    get '/login'
    assert last_response.not_found?
  end
end
