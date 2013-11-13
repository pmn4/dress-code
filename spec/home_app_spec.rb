require 'helpers/home_spec_helper'

describe 'Home app' do
  it 'should GET /' do
    get '/'
    last_response.should be_redirect
    follow_redirect!
    last_request.url.should == 'http://example.org/index.html'
  end
end

