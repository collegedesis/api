class BulletinScoreKeeper
  RECENCY_WEIGHT    = 0.70
  POPULARITY_WEIGHT = 0.15
  AUTHOR_REP_WEIGHT = 0.15
  attr_accessor :bulletin

  def initialize(bulletin)
    @bulletin = bulletin
  end

  def update_score
    bulletin.score = score
    update_high_score if score > bulletin.high_score
    bulletin.save
  end

  def score
    RECENCY_WEIGHT    * recency_score     +
    POPULARITY_WEIGHT * popularity_score  +
    AUTHOR_REP_WEIGHT * author_reputation
  end

  def author_reputation
    1
  end

  # TODO Algorithm is not tested
  def recency_score
    now = DateTime.now
    birth = bulletin.created_at.to_datetime
    age = now - birth
    score = 2 ** -(age)
    normalize(score)
  end

  # TODO algorithm is not tested
  def popularity_score
    num_of_votes = bulletin.votes.length
    raw = (num_of_votes + num_of_clicks) / 2.0
    score = Math.log(raw + 1)
    normalize(score)
  end

  # TODO add specs for this
  def num_of_clicks
    begin
      token = ENV['BITLY_ACCESS_TOKEN']
      escaped_url = CGI::escape(bulletin.shortened_url)

      uri = URI.parse "https://api-ssl.bitly.com/v3/link/clicks?access_token=#{token}&link=#{escaped_url}"

      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      hash = JSON.parse(response.body)
      hash["data"]["link_clicks"]
    rescue
      1
    end
  end

  private

  def update_high_score
    bulletin.high_score = score
  end

  def normalize(score)
    100 * score
  end
end