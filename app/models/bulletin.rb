class Bulletin < ActiveRecord::Base
  include Slugify
  attr_accessible :body, :title, :url, :bulletin_type, :user_id, :slug, :is_dead, :shortened_url, :popularity_score, :recency_score
  before_save :normalize_title
  before_save :nullify_body, :if => :is_link?
  before_create :create_slug, :shorten_url

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
  scope :has_author, conditions: 'user_id IS NOT NULL'
  scope :popular, conditions: 'popularity_score > 1'
  scope :newest, conditions: 'popularity_score = 1'

  def author_id
    user.memberships.first.organization.id if user.approved?
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

  def self.sort_by_score(bulletins)
    return bulletins.sort_by{|x| x.score }.reverse
  end

  def self.homepage
    Bulletin.paginate(Bulletin.alive.popular)
  end

  def self.recent
    Bulletin.paginate(Bulletin.alive.newest)
  end

  def self.paginate(bulletins)
    page_size = 10
    bulletins.sort_by!(&:score).reverse!
    bulletins.each_slice(page_size).to_a
  end

  def relative_local_url
    url.present? ? url : "#/bulletins/#{slug}"
  end

  def url_to_serialize
    Rails.env.production? ? shortened_url : relative_local_url
  end

  def promote
    orgs = Organization.reachable
    orgs.each do |org|
      OrganizationMailer.bulletin_promotion(self, org).deliver
    end
  end

  def score
    0.70 * recency_score + 0.10 * popularity_score + 0.10 * user_reputation + 0.10 * affiliation_reputation
  end

  def update_recency_score
    score = Scorekeeper.calc_recency_score(self)
    self.update_attributes(recency_score: score)
  end

  def update_popularity_score
    score = Scorekeeper.calc_popularity_score(self)
    self.update_attributes(popularity_score: score)
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

  def author_is_admin?
    org = Organization.where(name: "CollegeDesis").first
    user.memberships.map(&:organization_id).include?(org.id) if org
  end

  def tweet
    # We return true or false values
    # so that the wrapper `.tweet_top` method
    # knows if the tweet successed or failed
    begin
      Twitter.update "#{self.title} - #{shortened_url}"
      return true
    rescue => e
      puts "#{e.inspect} - #{self.title}"
      return false
    end
  end

  def self.tweet_top(num)
    # Tweet 3 bulletins.
    # If one fails to tweet successfully
    # go to the next one
    bulletins = Bulletin.homepage[0]
    counter = 0
    tweeted = 0
    while tweeted < 3 do
      bulletin = bulletins[counter]
      if bulletin
        response = bulletin.tweet
        counter += 1
        tweeted += 1 if response
      else
        break
      end
    end
  end

  def self.top(num)
    Bulletin.homepage("1")[0..(num - 1)]
  end

  def self.update_scores
    Bulletin.alive.each do |bulletin|
      bulletin.update_popularity_score
      bulletin.update_recency_score
    end
  end

  def normalize_title
    if title == title.upcase || title == title.downcase
      self.title = title.split.map(&:capitalize).join(' ')
    end
  end

  # this is run as a before save callback for link type bulletins
  def nullify_body
    self.body = nil
  end

  def approved?
    user.approved?
  end

  # run as before_create callback
  def shorten_url
    if Rails.env.production?
      client = Bitly.client
      to_shorten = if self.is_post?
        "https://collegedesis.com/" + relative_local_url
      else
        relative_local_url
      end
      self.shortened_url = client.shorten(to_shorten).short_url
    end
  end
end
