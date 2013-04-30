class VoteObserver < ActiveRecord::Observer

  def after_create(vote)
    bulletin = vote.votable if vote.votable_type = "Bulletin"
    bulletin.tweet if bulletin && bulletin.is_popular?
  end
end