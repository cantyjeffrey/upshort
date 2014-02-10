require File.expand_path '../../test.rb', __FILE__

TESTFILE = File.expand_path '../files/gob.jpeg', __FILE__
TESTNAME = 'TEST0001'
TESTSHORT = "#{app.settings.app_root}/public/uploads/#{TESTNAME}.short.jpeg"

describe 'GET short' do
  before do
    FileUtils.copy(TESTFILE, TESTSHORT)
  end
  after do
    FileUtils.remove(TESTSHORT)
  end
  it 'shows the short' do
    get "/#{TESTNAME}"
    assert last_response.ok?
  end
  it 'fails for nonexistent shorts' do
    get "/THISISFAKE"
    assert last_response.not_found?
  end
end

describe 'INDEX shorts' do
  before do
    FileUtils.copy(TESTFILE, TESTSHORT)
  end
  after do
    FileUtils.remove(TESTSHORT) if File.exists?(TESTSHORT)
  end
  it 'is just the login page when logged out' do
    get '/'
    assert last_response.body.include? 'Please Login'
  end
  it 'shows your shorts when logged in' do
    login_user!
    get '/'
    assert last_response.body.include? TESTNAME
  end
end

describe 'DELETE short' do
  before do
    FileUtils.copy(TESTFILE, TESTSHORT)
  end
  after do
    FileUtils.remove(TESTSHORT) if File.exists?(TESTSHORT)
  end
  it 'fails when not logged in' do
    delete "/#{TESTNAME}"
    assert last_response.not_found?
  end
  it 'fails removes the file' do
    login_user!
    delete "/#{TESTNAME}"
    assert last_response.successful?
    refute File.exists?(TESTSHORT)
  end
end
