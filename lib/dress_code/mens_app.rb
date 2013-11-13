require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?  # in dev, reload your app every time you make a change.  no more restarting!
require 'json'

require 'gilt'
require 'gilt/client'

module Gilt
  class Client
    class Products
      get :query, '/products'
    end
  end
end

module DressCode
	class MensApp < Sinatra::Base
		configure :development do
			register Sinatra::Reloader
		end

		before do
			content_type :json
			@product_client = Gilt::Product.client('0b6c9ad5cbc67f6c1d7ff738f6e19d4a')
			@sale_client = Gilt::Sale.client('0b6c9ad5cbc67f6c1d7ff738f6e19d4a')
		end

		get '/' do
			request = @product_client.query :store => Gilt::Stores::MEN,
                                      :q => 'shirt',
                                      :color => %w(blue red)
			response = request.perform
			response.to_json
		end

		get '/categories' do
			request = @product_client.categories
			response = request.perform.parse
			response.to_json
		end

		get '/sales' do
			request = @sale_client.active_in_store :store => Gilt::Stores::MEN
			response = request.perform.parse
			response.to_json
		end
	end
end

