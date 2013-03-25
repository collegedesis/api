class Bulletin < ActiveRecord::Base
  attr_accessible :body, :title, :url, :bulletin_type
  has_many :votes, :as => :votable

  # bulletin_types:
  # post is 1
  # link is 2

  validates_presence_of :title
  validates_presence_of :body, :if => :is_post?
  validates_presence_of :url, :if => :is_link?

  def self.find_by_title(title)
    Bulletin.where("lower(title) = lower(:title)", :title => title)
  end

  def is_link?
    bulletin_type == 2
  end

  def is_post?
    bulletin_type == 1
  end

  def self.sorted
    Bulletin.all.sort_by{|x| x.votes.length }.reverse[0..4]
  end

  def self.newest
    Bulletin.all.sort_by(&:created_at).reverse[0..4]
  end

  def self.homepage
    (Bulletin.sorted + Bulletin.newest).uniq
  end
end
