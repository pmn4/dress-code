require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?  # in dev, reload your app every time you make a change.  no more restarting!

module DressCode
	class HomeApp < Sinatra::Base
		configure :development do
			register Sinatra::Reloader
		end

    set :public_folder, 'public'

		get '/' do
      redirect '/index.html'
		end
	end
end
