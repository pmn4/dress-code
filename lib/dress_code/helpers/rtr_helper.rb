require 'rtr/clients/user_service_client'
require 'rtr/clients/product_catalog_client'

module RTR
	module Models
		class Collection # extends rtr_ruby_api_clients > lib > RTR::Models::Collection
			attr_accessor :styles
			attr_accessor :rejected_styles

			attr_reader :label
			attr_reader :search

			def meta
				@meta ||= JSON.parse(name) rescue nil
				# this is a super gross hack... deal with it!
				@label = @meta.present? ? @meta['name'] : self.name
				@search = @meta.present? ? @meta['search'] : self.name
				# (end) this is a super gross hack... deal with it!
				@meta
			end

			def dress_code?
				meta.present?
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
				self.instance_variables.each do |iv|
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
			config = {
				:host => "http://userservice-lb#{'n' if ENV['RACK_ENV'] == 'production'}.stage.renttherunway.it:8088"
			}
			config[:username] = ENV['USER_SERVICE_USERNAME'].nil? ? 'username' : ENV['USER_SERVICE_USERNAME']
			config[:password] = ENV['USER_SERVICE_PASSWORD'].nil? ? 'password' : ENV['USER_SERVICE_PASSWORD']
			@user_service_client ||= UserServiceClient.new(config)
			@user_service_client
		end
		def self.product_catalog_client
			config = {
				:host => "http://pcvarnish-lb#{'n' if ENV['RACK_ENV'] == 'production'}.stage.renttherunway.it:6081"
			}
			config[:username] = ENV['PRODUCT_CATALOG_USERNAME'].nil? ? 'username' : ENV['PRODUCT_CATALOG_USERNAME']
			config[:password] = ENV['PRODUCT_CATALOG_PASSWORD'].nil? ? 'password' : ENV['PRODUCT_CATALOG_PASSWORD']
			@product_catalog_client ||= ProductCatalogClient.new(config)
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