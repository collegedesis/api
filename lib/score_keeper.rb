class ScoreKeeper
  def self.calc_recency_score(bulletin)
    now = DateTime.now
    birth = bulletin.created_at.to_datetime
    age = now - birth
    score = 2 ** -(age)
    return 100 * score # to normalize
  end

  def self.calc_popularity_score(bulletin)
    num_of_votes = bulletin.votes.length
    num_of_clicks = get_clicks(bulletin.shortened_url)
    raw = (num_of_votes + num_of_clicks) / 2.0
    score = Math.log(raw + 1)
    return 100 * score
  end

  def self.get_clicks(short_url)
    begin
      token = ENV['BITLY_ACCESS_TOKEN']
      escaped_url = CGI::escape(short_url)

      request_url = "https://api-ssl.bitly.com/v3/link/clicks?access_token=#{token}&link=#{escaped_url}"
      uri = URI.parse(request_url)
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