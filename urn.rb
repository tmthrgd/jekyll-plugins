require_relative "ruby-uuid"

class Jekyll::UUIDGenerator < Jekyll::Generator
	priority :lowest
	
	def generate site
		base = ""
		base = site.config["url"] if site.config.has_key? "url"
		base ||= site.config["uri"] if site.config.has_key? "uri"
		base ||= site.config["domain"] if site.config.has_key? "domain"
		base ||= "file://#{site.source}"
		
		uri = URI.parse base
		
		if uri.scheme.nil?
			base = "http://#{base}"
			uri = URI.parse base
		end
		
		site.config["urn"] =
			if uri.host
				UUID.create_v5 uri.host.downcase, UUID::NameSpace_DNS
			else
				UUID.create_v5 base, UUID::NameSpace_URL
			end.to_uri unless site.config.has_key? "urn"
		
		(site.posts + site.pages).each do |page|
			next if page.data.has_key? "urn"
			
			page.data["urn"] = UUID.create_v5(URI.join(base, page.url).to_s, UUID::NameSpace_URL).to_uri
		end
	end
end