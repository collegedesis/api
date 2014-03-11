class BulletinTweeter
  attr_accessor :bulletin
  TOTAL_TWEET_LENGTH = 140
  SEPARATOR = "-"

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

  def mentioned_author
    handle = bulletin.author_twitter
    handle.present? ? "@#{handle}" : nil
  end

  def tweet_text
    str = "#{title_to_tweet} - #{url_to_tweet}"
    mentioned_author.present? ? "#{str} cc #{mentioned_author}" : str
  end

  def available_title_length
    len = TOTAL_TWEET_LENGTH - (" - ".length) - url_to_tweet.length
    mentioned_author.present? ? (len - mentioned_author.length) : len
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
