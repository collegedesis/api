class VoteObserver < ActiveRecord::Observer

  def after_create(vote)
    bulletin = vote.votable if vote.votable_type = "Bulletin"
    bulletin.update_popularity if bulletin
  end
end