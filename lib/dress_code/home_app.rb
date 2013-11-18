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

		get '/filters' do
			results = RtrHelper::get_dress_code_shortlists

			content_type :json
			{:filters => results}.to_json
		end

		get '/filter' do
			shortlist_id = params[:shortlistId]
			if shortlist_id.present?
				shortlist = RtrHelper::get_shortlist(shortlist_id)
			else
				shortlist = RtrHelper::get_dress_code_shortlists().first
			end
			gilt_results = GiltHelper::query_results(shortlist.search)
			rtr_results = RtrHelper::query_results(shortlist.id)

			results = {:styles => gilt_results['products'], :count => gilt_results['total_found']}
			results[:styles].concat(rtr_results)
			results[:count] += rtr_results.length

			content_type :json
			results.to_json
		end

		post '/code' do #create
			params[:code]
			params[:styles]
			#save this sucker!

			code_id = 'abc123'

			redirect "/code/#{code_id}"
		end

		post '/code/:id' do #update
			params[:code]
			params[:styles]
			#save this sucker!

			code_id = 'abc123'

			redirect "/code/#{code_id}"
		end

    get '/code/:id' do
      content_type :json

      begin
        event = FacebookRoutes::Event.find(params[:id])
      rescue
        event = {}
      end

      event.to_json
    end

    get '/:id' do
      # Moving this to the server so we can use the ID param
      erb :event
    end

		error 400..510 do
			puts inspect
			request.env['sinatra_error']
		end
	end
end
