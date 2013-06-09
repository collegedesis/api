class BulletinObserver < ActiveRecord::Observer

  def after_create(bulletin)
    if Rails.env.production?
      bulletin.tweet if bulletin.author_is_admin?
    end
  end
end