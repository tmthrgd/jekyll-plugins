require 'ritex'

module Jekyll
	class MathML < Liquid::Block
		def initialize tag_name, markup, tokens
			@attributes = {
				:display => 'block'
			}
			
			markup.scan(Liquid::TagAttributes) do |key, value|
				@attributes[key.to_sym] = value
			end
			
			super
		end
		
		def render context
			parser = Ritex::Parser.new
			
			parser.parse(super.to_s, { :display => @attributes[:display] != 'inline' })
		end
	end
end

Liquid::Template.register_tag('math', Jekyll::MathML)