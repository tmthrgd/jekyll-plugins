require "nokogiri"

module Jekyll
	module NeedsHighlighterFilter
		def needs_highlighter input
			doc = Nokogiri::HTML input if input
			
			!doc.css('code[class*=language-]:not(.nohighlight)').empty? if doc
		rescue Exception => e
			Jekyll.logger.warn "Error: #{e.message}"
			
			true
		end
	end
end

Liquid::Template.register_filter(Jekyll::NeedsHighlighterFilter)