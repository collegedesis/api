class BulletinTweeter
  attr_accessor :bulletin
  TOTAL_TWEET_LENGTH = 140
  SEPARATOR = " - "

  def self.tweet_top(num)
    tweetable_bulletins = Bulletin.homepage.limit(num)
    tweetable_bulletins.each do |b|
      b.tweet if !b.expired
    end
  end

  def initialize(bulletin)
    @bulletin = bulletin
  end

  def tweet
    begin
      Twitter.update(tweet_text)
      true
    rescue => e
      puts "#{e.inspect} - #{title_to_tweet}"
      false
    end
  end

  def tweet_text
    title_to_tweet + SEPARATOR + url_to_tweet
  end

  def available_title_length
    TOTAL_TWEET_LENGTH - SEPARATOR.length - url_to_tweet.length
  end

  def title_to_tweet
    title = bulletin.title || ""

    if title.length > available_title_length
      title[0..(available_title_length - 4)] + "..."
    else
      title
    end
  end

  def url_to_tweet
    bulletin.shareable_link
  end

end