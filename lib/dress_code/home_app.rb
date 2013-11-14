require 'sinatra'
require 'sinatra/base'

require_relative 'routes/providers/facebook_routes'

module DressCode
	class HomeApp < Sinatra::Base
		configure :development do
			register Sinatra::Reloader
		end

		set :public_folder, 'public'

		register DressCode::FacebookRoutes

		get '/' do
			redirect '/index.html'
		end

		error 400..510 do
			puts inspect
			request.env['sinatra_error']
		end
	end
end
