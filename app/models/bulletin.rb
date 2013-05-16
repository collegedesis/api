class Bulletin < ActiveRecord::Base
  include Slugify
  attr_accessible :body, :title, :url, :bulletin_type, :user_id, :slug, :is_dead
  after_create :create_slug

  has_many :votes, :as => :votable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  belongs_to :user
  # bulletin_types:
  # post is 1
  # link is 2

  validates_presence_of :title
  validates_presence_of :body, :if => :is_post?
  validates_presence_of :url, :if => :is_link?
  validates_presence_of :user_id
  validates_uniqueness_of :url, :allow_nil => true, :allow_blank => true

  scope :alive, where(:is_dead => false)

  def author_id
    user.memberships.first.organization.id if user
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
    Bulletin.alive.sort_by{|x| x.score }.reverse
  end

  def bulletin_url
    # TODO when we add comments we probably want site urls to link bulletins too
    if Rails.env.production?
      base_route = "https://collegedesis.com/#/bulletins/"
    else
      base_route = "http://localhost:3000/#/bulletins/"
    end
    base_route + slug
  end

  def shortened_url
    if Rails.env.production?
      client = Bitly.client
      client.shorten(bulletin_url).short_url
    end
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

  def recency_score
    # the older the bulletin, the larger the number
    raw = (Time.now - created_at)
    # so we'll inverse it
    inverse = 1/raw
    # and then multiple by some outlandish large number to make it human readable
    inverse * 1000000
  end

  def popularity_score
    votes.length > 0 ? votes.length : 1
  end

  def user_reputation
    # TODO
    1
  end

  def affiliation_reputation
    # TODO
    1
  end

  def voted_by_user?(user)
    votes.map(&:user_id).include? user.id
  end

  def tweet
    url = Rails.env.production? ? shortened_url : bulletin_url
    begin
      Twitter.update "#{self.title} - #{url}"
    rescue => e
      puts "Twitter update failed: #{e.inspect}"
    end
  end

  def is_popular?
    votes.count > 1 && votes.count % 5 == 0
  end

  def author_is_admin?
    org = Organization.where(name: "CollegeDesis").first
    user.memberships.map(&:organization_id).include?(org.id)
  end

  def self.tweet_top(num)
    Bulletin.top(num).each { |b| b.tweet }
  end

  def self.top(num)
    Bulletin.homepage[0..(num-1)]
  end

end
