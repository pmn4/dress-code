require 'helpers/mens_spec_helper'

describe 'Mens app' do
  it 'should GET /' do
    get '/'
    last_response.should be_ok
  end

  # We probably don't ACTUALLY want to hit the API going forward, but I think it's an OK sanity check for now
  it 'should GET /categories' do
    get '/categories'
    last_response.should be_ok
  end

  it 'should GET /sales' do
    get '/sales'
    last_response.should be_ok
  end
end

