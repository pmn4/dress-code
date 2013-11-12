ENV['RACK_ENV'] = 'test'

Dir[File.dirname(__FILE__) + '/../lib/**/*.rb'].each do |file|
  require file
end

RSpec.configure do |config|
  config.mock_with :rspec

  # Run specs in random order to surface any order dependencies
  config.order = 'random'
end

