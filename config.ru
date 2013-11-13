require 'rubygems'

require File.dirname(__FILE__) + '/boot.rb'
config_dir = File.dirname(__FILE__) + '/config'

Bundler.require(:default)
require 'sass/plugin/rack'
require './lib/dress_code/home_app'

# app map
run Rack::URLMap.new({
  "/"        => DressCode::HomeApp,
  "/mens"    => DressCode::MensApp,
  "/womens"  => DressCode::WomensApp
})

# use SCSS for styling
Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

