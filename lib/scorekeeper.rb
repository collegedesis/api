class Scorekeeper
  def self.calc_recency_score(bulletin)
    now = DateTime.now
    birth = bulletin.created_at.to_datetime
    age = now - birth
    score = 2 ** -(age)
    return 100 * score # to normalize
  end

  def self.calc_popularity_score(bulletin)
    num_of_votes = bulletin.votes.length
    num_of_clicks = get_clicks(bulletin)
    raw = (num_of_votes + num_of_clicks) / 2.0
    score = Math.log(raw + 1)
    return 100 * score
  end
end