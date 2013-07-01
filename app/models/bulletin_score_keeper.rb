class BulletinScoreKeeper
  attr_accessor :bulletin

  def initialize(bulletin)
    @bulletin = bulletin
  end

  def update_score
    attrs = { score: score }
    # if this score is a new high score, add it to attrs
    attrs[:high_score] = score if score > bulletin.high_score
    bulletin.update_attributes(attrs)
  end

  def score
    # TODO pull out weights into constants
    0.70 * recency_score +
    0.15 * popularity_score   +
    0.15 * author_reputation
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
    return 100 * score # to normalize
  end

  # TODO algorithm is not tested
  def popularity_score
    num_of_votes = bulletin.votes.length
    raw = (num_of_votes + num_of_clicks) / 2.0
    score = Math.log(raw + 1)
    return 100 * score
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
end