class Bulletin < ActiveRecord::Base
  attr_accessible :body, :title, :url, :bulletin_type, :user_id, :slug
  after_create :create_slug

  has_many :votes, :as => :votable, :dependent => :delete_all
  belongs_to :user
  # bulletin_types:
  # post is 1
  # link is 2

  validates_presence_of :title
  validates_presence_of :body, :if => :is_post?
  validates_presence_of :url, :if => :is_link?
  validates_presence_of :user_id

  def author
    user.memberships.first.organization.name if user
  end

  def self.find_by_title(title)
    Bulletin.where("lower(title) = lower(:title)", :title => title).first
  end

  def is_link?
    bulletin_type == 2
  end

  def is_post?
    bulletin_type == 1
  end

  def score
    recency_score * popularity_score * user_reputation * affiliation_reputation
  end

  def self.homepage
    Bulletin.all.sort_by{|x| x.score }.reverse[0..9]
  end

  def bulletin_url
    # TODO when we add comments we probably want site urls to link bulletins too
    if Rails.env.production?
      base_route = "https://collegedesis.com/#/bulletins/"
    else
      base_route = "http://localhost:3000/#/bulletins/"
    end
    url? ? url : base_route + slug
  end

  def intro
    self.body[0...100] + "..." if bulletin_type == 1
  end

  def promote(orgs=[])
    # if we don't get an array of organizations, we'll get all of them.
    # TODO figure out a way to map `orgs` to just those with email addresses upfront.
    orgs.blank? ? orgs = Organization.with_email : orgs
    orgs.each do |org|
      OrganizationMailer.bulletin_promotion(self, org).deliver if org.has_email?
    end
  end
  def create_slug
    self.update_attributes(slug: title.parameterize)
  end

  def recency_score
    # the older the bulletin, the larger the number
    raw = (Time.now - created_at)
    # so we'll inverse it
    inverse = 1/raw
    # and then multiple by some outlandish large number to make it human readable
    inverse * 1000000
  end

  def popularity_score
    votes.length
  end

  def user_reputation
    # TODO
    1
  end

  def affiliation_reputation
    # TODO
    1
  end

end