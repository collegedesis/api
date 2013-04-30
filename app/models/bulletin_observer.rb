class BulletinObserver < ActiveRecord::Observer

  def after_create(bulletin)
    bulletin.tweet if bulletin.author_is_admin?
  end
end