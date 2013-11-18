module DressCode
	module GiltHelper
		def self.gilt_api_key
			ENV['GILT_API_KEY'] || '4ca357757754e668de3549aeb2ec7e88' #sample app
		end
		def self.gilt_client
			@gilt_client ||= Gilt::Product.client(gilt_api_key)
			@gilt_client
		end
		def self.query_results(params)
			request = gilt_client.query
			p = {
				'apikey' => gilt_api_key,
				'store' => Gilt::Stores::MEN, # was causing 0 results
				'rows' => 100
			}.merge(params)
			p['q'] = p['q'].join(' ') if p['q'].respond_to?(:join)
			request.params(p)
			request.perform.parse
		end
	end
end
