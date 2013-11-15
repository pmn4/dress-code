require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?  # in dev, reload your app every time you make a change.  no more restarting!
require 'json'

require 'gilt'
require 'gilt/client'

require_relative 'helpers/gilt_helper'

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

		include GiltHelper

		before do
			content_type :json
		end

		get '/' do
			results = GiltHelper::query_results(params)
			results.to_json
		end

		get '/categories' do
			# request = @product_client.categories
			# response = request.perform.parse
			# response.to_json
			{:categories => ['Pants', 'Shirts', 'Other Shirts & Sweaters', 'Clothing', 'Sandals & Slip-Ons', 'Peacoats', 'Sweaters & Hoodies', 'Tops', 'Hats, Gloves & Scarves', 'Sportcoats', 'Tuxedos', 'Dress Shirts', 'Denim', 'Ties & Furnishings', 'V-Neck', 'Men', 'Serveware', 'Crewnecks', 'Slim Leg', 'Cargos', 'Undershirts', 'Socks, Underwear & Sleepwear', 'Vintage', 'Polos, Henleys & Tees', 'Crewneck', 'Outerwear', 'Formal Shirts', 'Dress Pants', 'Sweaters', 'Swimwear', 'Shorts & Swimwear', 'V-Necks', 'Clothing, Shoes & Accessories', 'Jackets', 'Suits & Sportcoats', 'Chinos', 'Straight Leg', 'Cords', 'Other Suits & Sportscoats', 'Other Clothing', 'Activewear', 'Suits', 'Relaxed Leg', 'Casual', 'Ties', 'Henleys', 'Trench & Raincoats', 'Polos', 'Bowties', 'Coats & Parkas', 'Cardigans', 'Ties, Pocket Squares & More', 'Socks', 'Shorts', 'Topcoats', 'Long Sleeve Sport Shirts', 'Casual Belts', 'Underwear', 'Shirts & Sweaters', 'Short Sleeve Sport Shirts', 'Leather Jackets', 'Oxfords', 'Hoodies', 'Tanks']}.to_json
		end

		get '/sales' do
			request = @sale_client.active_in_store
			response = request.perform.parse
			response.to_json
		end
	end
end

