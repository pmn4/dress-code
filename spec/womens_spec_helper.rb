ENV['RACK_ENV'] = 'test'

require 'rack/test'

module WomensMixin
  include Rack::Test::Methods
  Dir[File.dirname(__FILE__) + '/../lib/**/*.rb'].each do |file|
    require file
  end

  def app
    DressCode::WomensApp
  end
end

RSpec.configure do |config|
  config.include WomensMixin
  config.mock_with :rspec
  config.order = 'random'
end

