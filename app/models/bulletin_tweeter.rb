class BulletinTweeter
  attr_accessor :bulletin
  @@TOTAL_TWEET_LENGTH = 140

  def initialize(bulletin)
    @bulletin = bulletin
  end

  def tweet
    begin
      Twitter.update(tweet_text)
      true
    rescue => e
      puts "#{e.inspect} - #{self.title}"
      false
    end
  end

  def tweet_text
    title_to_tweet + separator + url_to_tweet
  end

  def available_title_length
    total_tweet_length - separator.length - url_to_tweet.length
  end

  def title_to_tweet
    title = bulletin.title || ""

    if title.length > available_title_length
      title[0..(available_title_length - 4)] + "..."
    else
      title
    end
  end

  def  url_to_tweet
    bulletin.shortened_url || "no_url_available"
  end

  def separator
    # TODO this should be a constant in this class.
    # How do you define constants inside a class?
    " - "
  end

  def total_tweet_length
    # TODO this should be a constant in this class.
    # How do you define constants inside a class?
    140
  end
end