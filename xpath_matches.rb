require "nokogiri"

module Jekyll::XPathMatchesFilter
	def xpath_matches input, selector
		return false unless input && selector
		
		doc = Nokogiri::HTML(input) { |config| config.nonet }
		
		doc ? !doc.xpath(selector).empty? : false
	end
end

Liquid::Template.register_filter Jekyll::XPathMatchesFilter