class Bulletin < ActiveRecord::Base
  attr_accessible :body, :title, :url, :bulletin_type, :user_id
  has_many :votes, :as => :votable
  belongs_to :user
  # bulletin_types:
  # post is 1
  # link is 2

  validates_presence_of :title
  validates_presence_of :body, :if => :is_post?
  validates_presence_of :url, :if => :is_link?
  validates_presence_of :user_id

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

  def bulletin_url
    # TODO when we add comments we probably want site urls to link bulletins too
    domain = "https://collegedesis.com/#/"
    route = "bulletins/"
    url? ? url : domain + route + title.parameterize
  end

  def intro
    self.body[0...50] + "..." if bulletin_type == 1
  end

  def promote(orgs=[])
    if orgs.blank?
      Organization.all.each { |org| OrganizationMailer.bulletin_promotion(self, org).deliver }
    else
      orgs.each { |org| OrganizationMailer.bulletin_promotion(self, org).deliver }
    end
  end
end