module Jekyll::HandleizeFilter
	def handleize input
		return if input.empty?
		
		handle = input.dup
		
		handle.downcase!
		handle.gsub! /[^-_a-zA-Z0-9]/, "-"
		handle.gsub! /-+/, "-"
		handle.gsub! /^[-_]+|[-_]+$/, ""
		
		handle
	end
end

Liquid::Template.register_filter Jekyll::HandleizeFilter