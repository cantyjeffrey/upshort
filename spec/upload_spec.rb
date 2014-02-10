require File.expand_path '../../test.rb', __FILE__

TESTFILE = File.expand_path '../files/gob.jpeg', __FILE__

describe 'GET upload' do
  it 'shows the upload page' do
    login_user!
    get '/upload'
    assert last_response.ok?
    assert last_response.body.include? 'Upload a file'
  end
  it 'is hidden when not logged in' do
    get '/upload'
    assert last_response.not_found?
  end
end

describe 'POST upload' do
  it 'requires you to be logged in' do
    post '/upload'
    assert last_response.not_found?
  end
  it 'requires a file' do
    login_user!
    post '/upload'
    puts last_response.status
    assert last_response.bad_request?
    assert last_response.body.include? 'must supply a valid file'
  end
  it 'takes a file' do
    login_user!
    post '/upload', file: Rack::Test::UploadedFile.new(TESTFILE, 'image/jpeg')
    assert last_response.redirect?
    short = last_response.headers['X-Short']
    Dir.glob("#{app.settings.app_root}/public/uploads/#{short}.*").each do |f|
      File.delete(f)
    end
  end
end
