class BulletinObserver < ActiveRecord::Observer

  def after_create(bulletin)
    # if the bulletin is posted by someone from the CollegeDesis organization
    # we'll tweet it out when it was created.
    # TODO we need a scheduling system. Maybe tap into the Buffer API?
    org = Organization.where(name: "CollegeDesis").first
    if bulletin.user.memberships.map(&:organization).include?(org)
      Twitter.update(bulletin.title + " " + bulletin.bulletin_url )
    end
  end
end