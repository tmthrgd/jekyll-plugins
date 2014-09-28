module Jekyll
	module Converters
		class Markdown
			class CustomKramdownParser < KramdownParser
				def convert content
					# Check for use of coderay
					if @config['kramdown']['use_coderay']
						%w[wrap line_numbers line_numbers_start tab_width bold_every css default_lang].each do |opt|
							key = "coderay_#{opt}"
							@config['kramdown'][key] = @config['kramdown']['coderay'][key] unless @config['kramdown'].key?(key)
						end
					end
					
					Kramdown::Document.new(content, Utils.symbolize_hash_keys(@config["kramdown"])).to_h1_links_html
				end
			end
		end
	end
end

module Kramdown
	module Converter
		class H1LinksHtml < Html
			def convert_header el, indent
				if @options[:auto_ids] && !el.attr['id']
					el.attr['id'] = generate_id(el.options[:raw_text])
				end
				
				if el.attr['id']
					el.children.unshift ::Kramdown::Element.new(:a, nil, { "href" => "##{el.attr['id']}" })
				end
				
				super
			end
		end
	end
end