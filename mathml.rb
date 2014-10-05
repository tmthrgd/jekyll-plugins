module MathML
	begin
		require "itextomml"
		
		def self.parse tex, block
			@parser ||= Itex2MML::Parser.new
			block ? @parser.block_filter(tex) : @parser.inline_filter(tex)
		end
	rescue LoadError
		begin
			require "ritex"
		rescue LoadError
			STDERR.puts "You are missing a library required for mathml. Please run either:"
			STDERR.puts " $ [sudo] gem install itextomml"
			STDERR.puts "or:"
			STDERR.puts " $ [sudo] gem install ritex"
			raise Errors::FatalException.new "Missing dependency: itextomml or ritex"
		end
		
		def self.parse tex, block
			@parser ||= Ritex::Parser.new
			@parser.parse tex, { :display => block }
		end
	end
end

class Jekyll::MathML < Liquid::Block
	def initialize tag_name, markup, tokens
		@attributes = {
			:display => "block"
		}
		
		markup.scan(Liquid::TagAttributes) { |key, value| @attributes[key.to_sym] = value }
		
		super
	end
	
	def render context
		MathML.parse super.to_s, !@attributes[:display].eql?("inline")
	end
end

Liquid::Template.register_tag "math", Jekyll::MathML

# Kramdown math support
begin
	require "kramdown"
	
	class Kramdown::Converter::Html
		def convert_math el, indent
			block = el.options[:category].eql? :block
			
			attr = el.attr.dup
			attr.delete "display"
			attr.delete "xmlns"
			
			mathml = MathML.parse el.value, block
			mathml.insert "<math".length, html_attributes(attr)
			
			block ? "#{" " * indent}#{mathml}\n" : mathml
		end
	end
rescue LoadError
end