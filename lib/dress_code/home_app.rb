require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?  # in dev, reload your app every time you make a change.  no more restarting!

require_relative 'routes/providers/facebook_routes'

module DressCode
	class HomeApp < Sinatra::Base
		configure :development do
			register Sinatra::Reloader
		end

		register DressCode::FacebookRoutes

		get '/' do
		  "Hello World!"
		end

		not_found do
			puts request.inspect
		end

		@routes.each do |verb, routes|
			routes.each do |route|
				puts "#{verb} #{route[0]}"
			end
		end
	end
end
