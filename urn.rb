require File.dirname(__FILE__) + '/ruby-uuid.rb'

module Jekyll
	class UUIDGenerator < Jekyll::Generator
		priority :lowest
		
		def generate site
			base = ""
			base = site.config["url"] if site.config.has_key? "url"
			base ||= site.config["uri"] if site.config.has_key? "uri"
			base ||= site.config["domain"] if site.config.has_key? "domain"
			base ||= "file://#{site.source}"
			
			uri = URI.parse base
			base = "http://#{base}" if uri.scheme.nil?
			uri = URI.parse base if uri.scheme.nil?
			
			unless site.config.has_key? "urn"
				site.config["urn"] = UUID.create_v5(uri.host.downcase, UUID::NameSpace_DNS).to_uri if uri.host
				site.config["urn"] = UUID.create_v5(base, UUID::NameSpace_URL).to_uri unless uri.host
			end
			
			site.posts.each do |post|
				unless post.data.has_key? "urn"
					url = URI.join(base, post.url).to_s
					
					post.data["urn"] = UUID.create_v5(url, UUID::NameSpace_URL).to_uri
				end
			end
			
			site.pages.each do |page|
				unless page.data.has_key? "urn"
					url = URI.join(base, page.url).to_s
					
					page.data["urn"] = UUID.create_v5(url, UUID::NameSpace_URL).to_uri
				end
			end
		end
	end
end