module DressCode
	module GiltHelper
		def self.gilt_client
			@gilt_client ||= Gilt::Product.client('0b6c9ad5cbc67f6c1d7ff738f6e19d4a')
			@gilt_client
		end
		def self.query_results(params)
			request = gilt_client.query
			p = {
				'apikey' => '0b6c9ad5cbc67f6c1d7ff738f6e19d4a',
				'store' => Gilt::Stores::MEN,
				'rows' => 100
			}.merge(params)
			p['q'] = p['q'].join(' ') if p['q'].respond_to?(:join)
			request.params(p)
			request.perform.parse
		end
	end
end