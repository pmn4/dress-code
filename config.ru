require File.dirname(__FILE__) + '/boot.rb'

config_dir = File.dirname(__FILE__) + '/config'

# app map
run Rack::URLMap.new({
    "/"               => DressCode::HomeApp,
    "/mens"           => DressCode::MensApp,
    "/womens"         => DressCode::WomensApp
})
