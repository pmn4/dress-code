ENV['RACK_ENV'] = 'test'

require 'rack/test'

module MensMixin
  include Rack::Test::Methods
  Dir[File.dirname(__FILE__) + '/../lib/**/*.rb'].each do |file|
    require file
  end

  def app
    DressCode::MensApp
  end
end

RSpec.configure do |config|
  config.include MensMixin
  config.mock_with :rspec
  config.order = 'random'
end

