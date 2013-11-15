require 'sinatra'
require 'sinatra/base'
require 'compass'

require_relative 'routes/providers/facebook_routes'
require_relative 'helpers/gilt_helper'
require_relative 'helpers/rtr_helper'

module DressCode
	class HomeApp < Sinatra::Base
		set :public_folder, 'public'

		configure :development do
			register Sinatra::Reloader
			Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
		end

		register DressCode::FacebookRoutes

		get '/styles/:name.css' do
			content_type 'text/css', :charset => 'utf-8'
			scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
		end

		get '/' do
			redirect '/index.html'
		end

		get '/filter' do
			gilt_results = GiltHelper::query_results(params)
			rtr_results = RtrHelper::query_results(params)

			results = {:styles => gilt_results['products'], :count => gilt_results['total_found']}
			results[:styles].concat(rtr_results)
			results[:count] += rtr_results.length

			content_type :json
			results.to_json
		end

   get '/code' do
      # We'll just pick the first event in the DB for now
      content_type :json
      event = FacebookRoutes::Event.first
      event.to_json
    end

    get '/event_summary' do
      redirect '/event.html'
    end
		error 400..510 do
			puts inspect
			request.env['sinatra_error']
		end
	end
end
