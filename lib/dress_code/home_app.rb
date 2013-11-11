require 'sinatra'
require 'sinatra/base'

module DressCode
    class HomeApp < Sinatra::Base
		get '/' do
		  "Hello World!"
		end
	end
end