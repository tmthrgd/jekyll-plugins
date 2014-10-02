require "kramdown"

module Kramdown
	class Converter::Html
		alias_method :super_convert_header, :convert_header
		def convert_header el, indent
			el.attr["id"] = generate_id el.options[:raw_text] if @options[:auto_ids] && !el.attr["id"]
			
			el.children.unshift Element.new(:a, nil, { "href" => "##{el.attr["id"]}" }) if el.attr["id"]
			
			super_convert_header el, indent
		end
	end
end