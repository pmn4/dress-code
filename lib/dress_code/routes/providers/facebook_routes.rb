require 'sinatra'
require 'sinatra/base'

require 'uri'

require 'koala'

module DressCode
	module FacebookRoutes
		def self.registered(app)
			@@provider_name = 'facebook'
			@@app_id = '356865567790385'
			@@secret_key = 'c79a6cf949fb13dfcf66fb464c3053b4' # todo: move to config
			@@callback_path = "/#{@@provider_name}/oauth"

			app.get "/#{@@provider_name}/login" do
				callback_url = URI(request.url)
				callback_url.path = @@callback_path
				@oauth = Koala::Facebook::OAuth.new(@@app_id, @@secret_key, callback_url.to_s)

				redirect @oauth.url_for_oauth_code
			end

			app.get @@callback_path do
				begin
					callback_url = URI(request.url)
					callback_url.path = @@callback_path
					@oauth = Koala::Facebook::OAuth.new(@@app_id, @@secret_key, callback_url.to_s)
					access_token = @oauth.get_access_token(params[:code])
					@graph = Koala::Facebook::API.new(access_token)
					me = @graph.get_object('me')
					me.to_json
				rescue Exception => e
					puts e
				end
			end

			app.get "/#{@@provider_name}/events" do
			end
		end
	end
end