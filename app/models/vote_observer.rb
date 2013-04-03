class VoteObserver < ActiveRecord::Observer

  def after_create(vote)
    bulletin = vote.votable if vote.votable_type = "Bulletin"

    if bulletin
      # every 5th vote we'll tweet the bulletin and the url
      # TODO use bit.ly api to do short urls
      if bulletin.votes.count > 1 && bulletin.votes.count % 5 == 0
        begin
          Twitter.update(bulletin.title + " " + bulletin.bulletin_url )
        else
          puts "Can't tweet this #{vote}"
        end
      end
    end
  end
end