require "linguist"

class Jekyll::Tags::LinguistColors < Liquid::Tag
	def initialize tag_name, markup, tokens
		@attributes = {
			:selector => ".language-{language}",
			:property => "background"
		}
		
		markup.scan(Liquid::TagAttributes) { |key, value| @attributes[key.to_sym] = value }
		
		super
	end
	
	def render context
		Linguist::Language.all.select{ |language| language.color }.map do |language|
			slug = language.name.gsub(/\s+/, "-").gsub(/([#+])/, "\\\\\\\\\\1").downcase
			
			"#{@attributes[:selector].gsub "{language}", slug} { #{@attributes[:property]}: #{language.color} }"
		end * "\n"
	end
end

Liquid::Template.register_tag "linguist_colors", Jekyll::Tags::LinguistColors