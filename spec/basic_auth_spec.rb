require File.expand_path '../../test.rb', __FILE__

TESTFILE = File.expand_path '../files/gob.jpeg', __FILE__
TESTNAME = 'TEST0001'
TESTSHORT = "#{app.settings.app_root}/public/uploads/#{TESTNAME}.short.jpeg"

describe 'basic authorize' do
  it 'hides upload with no auth' do
    get '/upload'
    assert last_response.not_found?
  end
  it 'shows the upload page with basic auth' do
    basic_authorize app.settings.username, app.settings.password
    get '/upload'
    assert last_response.ok?
  end
  it 'fails with bad basic auth' do
    basic_authorize 'test', 'blah'
    get '/upload'
    assert last_response.not_found?
  end
end
