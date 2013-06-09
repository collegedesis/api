class Bulletin < ActiveRecord::Base
  include Slugify
  attr_accessible :body, :title, :url, :bulletin_type, :user_id, :slug, :is_dead, :shortened_url, :popularity_score
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

  def author_id
    if user.approved?
      user.memberships.first.organization.id
    else
      user.id
    end
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

  def self.sort_by_score(bulletins)
    return bulletins.sort_by{|x| x.score }.reverse
  end

  def self.paginate(bulletins, page_size=10)
    page_size = page_size.to_f
    num_of_pages = (bulletins.length / page_size).ceil

    current_page = 0
    paginated_bulletins = []

    while current_page < num_of_pages do
      range_start = current_page * page_size
      range_end = range_start + (page_size - 1)
      paginated_bulletins <<  bulletins[range_start..range_end]
      current_page += 1
    end

    return paginated_bulletins
  end

  def self.available_for_pagination
    bulletins = Bulletin.has_author.alive
    bulletins = Bulletin.sort_by_score(bulletins)
    return bulletins.map { |b| b if b.approved? }.compact
  end

  def self.homepage(page)
    bulletins = Bulletin.available_for_pagination
    page = page.to_i
    bulletins_for_page = Bulletin.paginate(bulletins)[page - 1] || []
    return bulletins_for_page
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

  def recency_score
    # the older the bulletin, the larger the number
    raw = (Time.now - created_at)
    # so we'll inverse it
    inverse = 1/raw
    # and then multiple by some outlandish large number to make it human readable
    inverse * 1000000
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

  def is_popular?
    votes.count > 1 && votes.count % 5 == 0
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
    bulletins = Bulletin.available_for_pagination
    counter = 0
    tweeted = 0
    while counter < 3 do
      response = bulletins[counter].tweet
      counter += 1
      tweeted += 1 if response
    end
  end

  def self.top(num)
    Bulletin.homepage("1")[0..(num - 1)]
  end

  def self.update_scores
    Bulletin.available_for_pagination.each do |bulletin|
      bulletin.update_popularity
    end
  end

  def normalize_title
    if title == title.upcase || title == title.downcase
      self.title = title.split.map(&:capitalize).join(' ')
    end
  end

  def update_popularity
    self.update_attributes(popularity_score: votes.length)
    # TODO use number of clicks from bit.ly
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
