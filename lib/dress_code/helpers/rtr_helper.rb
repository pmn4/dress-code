require 'rtr/clients/user_service_client'
require 'rtr/clients/product_catalog_client'

module RTR
	module Models
		class Collection # extends rtr_ruby_api_clients > lib > RTR::Models::Collection
			attr_accessor :styles
			attr_accessor :rejected_styles

			def meta
				@meta ||= JSON.parse(name) rescue nil
				@meta
			end

			def dress_code?
puts '>>>>', @meta, name, '<<<<<'
				meta.present?
			end

			def label
				dress_code? ? meta['name'] : self.name
			end

			def search
				dress_code? ? meta['search'] : self.name
			end

			def styles?
				return self.length() > 0
			end

			def rejected_styles?
				return self.rejected_length() > 0
			end

			def length
				return @style_names.blank? ? 0 : @style_names.length
			end

			def rejected_length
				return @rejected_style_names.blank? ? 0 : @rejected_style_names.length
			end

			def as_json(options = {})
				hash = {}
				self.instance_variables.concat([:label, :search]).each do |iv|
					next if [:@styles, :@rejected_styles].include?(iv)

					iv_name = iv.to_s[1..-1]
					hash[iv_name.camelize(:lower)] = send(iv_name).as_json(options) if self.respond_to?(iv_name)
				end
				hash
			end
		end
	end
end

module DressCode
	module RtrHelper
		def self.user_service_client
			@user_service_client ||= UserServiceClient.new({
				:host => "http://userservice-lb.stage.renttherunway.it:8088",
				:username => 'photoadmin',
				:password => 'DC8B79F2-FCE1-4738-90A8-5391A28929C1'
			})
			@user_service_client
		end
		def self.product_catalog_client
			@product_catalog_client ||= ProductCatalogClient.new({
				:host => "http://pcvarnish-lb.stage.renttherunway.it:6081",
				:username => "username",
				:password => "password"
			})
			@product_catalog_client
		end
		def self.get_dress_code_shortlists()
			shortlists = user_service_client.get_collections(7172256)
			dress_code_shortlists = shortlists.select {|s| s.dress_code?}
		end
		def self.get_shortlist(id)
			return nil if id.blank?

			shortlist = user_service_client.get_collection(id)
			merge_shortlist_styles(shortlist)
			shortlist
		end
		def self.merge_shortlist_styles(shortlists)
			return if shortlists.blank?

			lists = shortlists.is_a?(Array) ? shortlists : [shortlists]

			style_names = lists.map{|l| [l.style_names, l.rejected_style_names]}.flatten.uniq.compact

			all_styles = product_catalog_client.get_items(style_names)

			if all_styles.kind_of?(Array)
				all_styles.compact!
			else
				all_styles = Array.new
			end

			lists.each do |list|
				list.styles = list.style_names.map{|sn| all_styles.find{|s| s['styleName'] == sn}}.compact unless list.style_names.nil?
				list.rejected_styles = list.rejected_style_names.map{|sn| all_styles.find{|s| s['styleName'] == sn}}.compact unless list.rejected_style_names.nil?
			end
		end
		def self.query_results(shortlist_id)
			shortlist = get_shortlist(shortlist_id)
			shortlist.styles
		end
	end
end