class BulletinScoreKeeper
  attr_accessor :bulletin

  def initialize(bulletin)
    @bulletin = bulletin
  end

  def update_score
    update_recency_score
    update_popularity_score
  end

  def update_recency_score
    bulletin.update_attributes(recency_score: recency_score)
  end

  def update_popularity_score
    bulletin.update_attributes(popularity_score: popularity_score)
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