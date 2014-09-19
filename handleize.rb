module Jekyll
	module HandleizeFilter
		def handleize input
			input.downcase.gsub(/[^-_a-zA-Z0-9]/, '-').gsub(/-+/, '-').gsub(/^[-_]+|[-_]+$/, '') if input
		end
	end
end

Liquid::Template.register_filter(Jekyll::HandleizeFilter)