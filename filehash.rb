require "digest/sha1"

module Jekyll::FileHash
	def file_hash input
		Digest::SHA1.hexdigest IO.read input
	end
end

Liquid::Template.register_filter Jekyll::FileHash