require 'sinatra'
require 'sinatra/base'

require 'uri'

require 'koala'

module DressCode
	module FacebookRoutes

    # We should probably move this elsewhere, but it's ok here for now
    class Event
      include Mongoid::Document

      field :event_data, type: String
    end

		TOKEN_COOKIE_NAME = 'fb_id'

		def self.registered(app)
			@@provider_name = 'facebook'
			@@app_id = '356865567790385'
			@@secret_key = 'c79a6cf949fb13dfcf66fb464c3053b4' # todo: move to config
			@@callback_path = "/#{@@provider_name}/oauth"

			Koala::Utils.logger.level = Logger::DEBUG

			app.get "/#{@@provider_name}/login" do
				callback_url = URI(request.url)
				callback_url.path = @@callback_path
				@oauth = Koala::Facebook::OAuth.new(@@app_id, @@secret_key, callback_url.to_s)

				redirect @oauth.url_for_oauth_code({:permissions => %w(email user_events publish_stream)})
			end

			app.get @@callback_path do
				callback_url = URI(request.url)
				callback_url.path = @@callback_path
				@oauth = Koala::Facebook::OAuth.new(@@app_id, @@secret_key, callback_url.to_s)
				access_token = @oauth.get_access_token(params[:code])

				response.set_cookie(TOKEN_COOKIE_NAME, {
					:domain => request.host,
					:httponly => true,
					:path => '/',
					:value => access_token
				})

				redirect "/#{@@provider_name}/events"
			end

			app.get "/#{@@provider_name}/events" do
				access_token = request.cookies[TOKEN_COOKIE_NAME]

				@graph = Koala::Facebook::API.new(access_token)
				me = @graph.get_object('me')
				events = @graph.get_connections(me['id'], 'events')

        # Write all events to Mongo
        events.each do |event|
          begin
            fb_event = Event.new({:event_data => event.to_json})
            fb_event.save
          rescue Exception => e
            puts "\n\nAn error occurred saving FB event data: #{e}\n\n"
           end
        end

        events.to_json
			end

			# app.post "/#{@@provider_name}/event/:event_id" do
			app.get "/#{@@provider_name}/event/:event_id/simple" do
				access_token = request.cookies[TOKEN_COOKIE_NAME]

				@graph = Koala::Facebook::API.new(access_token)
				me = @graph.get_object('me')
				post = @graph.put_wall_post('This Event Has a Dress Code', {
					:link => "http://dress-code.herokuapp.com/code/#{params[:code_id]}",
					:picture => 'http://dress-code.herokuapp.com/public/images/dress-code-logo.png',
					:type => 'dress-code-app:dress_code'
				}, params[:event_id])

        ################
        ##### TODO #####
        ################
        #
        # Write filter images to Mongo document

				post.to_json
			end

			# app.post "/#{@@provider_name}/event/:event_id" do
			app.get "/#{@@provider_name}/event/:event_id" do
puts 'THIS DOESN\'T WORK YET'
				access_token = request.cookies[TOKEN_COOKIE_NAME]

				@graph = Koala::Facebook::API.new(access_token)
				me = @graph.get_object('me')
				post = @graph.put_connections(params[:event_id], 'dress-code-app:dress_code', {
					:dress_code => {
						'product' => url.to_s,
						'image[0][url]' => 'http://zoomq.qiniudn.com/ZQScrapBook/ZqFLOSS/data/20130308122939/eric_weinstein@2x-491974aaea7dada90a3302a369b18127.jpg',
						'image[0][user_generated]' => 'true',
						'image[1][url]' => 'http://www.tokyois.com/main/wp-content/uploads/2011/02/Patrick_Newell_info.jpg',
						'image[1][user_generated]' => 'true',
						'fb:explicitly_shared' => true,
						'message' => '{this event} has a dress code... follow it!'
					}
				})
				post.to_json
			end
		end
	end
end
