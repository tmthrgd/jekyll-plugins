require "nokogiri"

module Jekyll::CSSMatchesFilter
	def css_matches input, selector
		return false unless input && selector
		
		doc = Nokogiri::HTML input
		
		return false unless doc
		
		!doc.css(selector).empty?
	rescue Exception => e
		Jekyll.logger.warn "Error: #{e.message}"
		
		false
	end
end

Liquid::Template.register_filter Jekyll::CSSMatchesFilter