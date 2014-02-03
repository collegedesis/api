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
    num_of_views = bulletin.views.length
    raw = num_of_views / 2.0
    score = Math.log(raw + 1)
    normalize(score)
  end

  private

  def update_high_score
    bulletin.high_score = score
  end

  def normalize(score)
    100 * score
  end
end