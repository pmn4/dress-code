require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?  # in dev, reload your app every time you make a change.  no more restarting!

require 'rtr/clients/product_catalog_client'

module DressCode
    class WomensApp < Sinatra::Base
		configure :development do
			register Sinatra::Reloader
		end

		get '/categories' do
			client = ProductCatalogClient.new({:host => "http://pcvarnish-lbn.stage.renttherunway.it:6081"})
			client.get_dress_categories
		end
	end
end