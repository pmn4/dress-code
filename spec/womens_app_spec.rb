require 'womens_spec_helper'

describe 'Womens app' do
  it 'should GET /categories' do
    get '/categories'
    last_response.should be_ok
  end
end

