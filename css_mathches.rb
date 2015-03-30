require "nokogiri"

module Jekyll::CSSMatchesFilter
	def css_matches input, selector
		return false unless input && selector
		
		doc = Nokogiri::HTML(input) { |config| config.nonet }
		
		doc ? !doc.css(selector).empty? : false
	end
end

Liquid::Template.register_filter Jekyll::CSSMatchesFilter