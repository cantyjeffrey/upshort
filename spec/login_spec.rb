require File.expand_path '../../test.rb', __FILE__

describe 'upshort login' do
  before { get '/' }

  it 'shows the login page' do
    assert last_response.ok?
    assert last_response.body.include? 'Please Login'
  end
end
