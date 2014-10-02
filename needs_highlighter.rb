require "nokogiri"

module Jekyll::NeedsHighlighterFilter
	def needs_highlighter input
		return false unless input
		
		doc = Nokogiri::HTML input
		
		return true unless doc
		
		!doc.css("code[class*=language-]:not(.nohighlight)").empty?
	rescue Exception => e
		Jekyll.logger.warn "Error: #{e.message}"
		
		true
	end
end

Liquid::Template.register_filter Jekyll::NeedsHighlighterFilter