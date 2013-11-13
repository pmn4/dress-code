require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?  # in dev, reload your app every time you make a change.  no more restarting!

require 'koala'

module DressCode
	module FacebookRoutes
		def self.registered(app)
			@@provider_name = 'facebook'
			@@app_id = '356865567790385'
			@@secret_key = 'c79a6cf949fb13dfcf66fb464c3053b4' # todo: move to config
			@@callback_path = "#{@@provider_name}/oauth"

			puts app.inspect

			app.get "#{@@provider_name}/login" do
				@oauth = Koala::Facebook::OAuth.new(@@app_id, @@app_secret, create_url(request.scheme, request.host, @@callback_path))

				erb :'login/facebook', :oath_url => @oauth.url_for_oauth_code
			end

			app.get @@callback_path do
			end

			app.get "#{@@provider_name}/events" do
				@graph = Koala::Facebook::API.new(params[:oauth_access_token])
				@graph.get_object('me')
			end
		end
	end
end