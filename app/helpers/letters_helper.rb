module LettersHelper
	def tweet_link(url)
		mention = "via=collegedesis"	
		"https://twitter.com/intent/tweet?text=#{url}&#{mention}"
	end
end