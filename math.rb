module Jekyll::MathFilter
	%w[acos acosh asin asinh atan atan2 atanh cbrt cos cosh erf erfc
		exp frexp gamma hypot ldexp lgamma log log10 log2 sin sinh
		sqrt tan tanh].each do |name|
		define_method name.to_sym do |*args|
			Math.send name, *args
		end
	end
	
	%w[abs abs2 divmod remainder].each do |name|
		define_method name.to_sym do |input, *args|
			input.send name, *args
		end
	end
end

Liquid::Template.register_filter Jekyll::MathFilter