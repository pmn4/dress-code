require 'home_spec_helper'

describe 'Home app' do
  before do
    get '/'
  end

  it 'should GET /' do
    last_response.should be_ok
  end

  it 'should greet us heartily' do
    last_response.body.should == 'Hello World!'
  end
end

