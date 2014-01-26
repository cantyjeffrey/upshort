require File.expand_path '../../test.rb', __FILE__

describe "my example app" do
  it "should successfully return a greeting" do
    get '/'
    assert_equal 'Welcome to my page!', last_response.body
  end
end
