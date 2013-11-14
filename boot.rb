ENV["RACK_ENV"] ||= "development"

require 'bundler'
require 'mongoid'

Bundler.setup
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

Dir["./lib/**/*.rb"].each { |f| require f }

# Mongoid config
Mongoid.load!('config/mongoid.yml')

