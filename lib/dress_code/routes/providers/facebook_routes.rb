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
			@@callback_url = ''

			app.get "#{@@provider_name}/login" do
				params[:provider_name] = @@provider_name
				params[:app_id] = @@app_id
				params[:secret_key] = @@secret_key

				erb :'login/facebook'
			end

			app.get "#{@@provider_name}/oauth" do
				# @oauth = Koala::Facebook::OAuth.new(@@app_id, @@app_secret, @@callback_url)
				# @oauth.get_user_info_from_cookies(cookies)
			end

			app.get "#{@@provider_name}/events" do
				@graph = Koala::Facebook::API.new(params[:oauth_access_token])
				@graph.get_object('me')
			end
		end
	end
end