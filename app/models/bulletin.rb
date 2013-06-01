class Bulletin < ActiveRecord::Base
  include Slugify
  attr_accessible :body, :title, :url, :bulletin_type, :user_id, :slug, :is_dead
  before_save :normalize_title
  before_save :nullify_body, :if => :is_link?
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

  def self.homepage(page)
    page = page.to_i
    bulletins = Bulletin.has_author.alive
    bulletins = bulletins.map { |b| b if b.approved? }.compact
    bulletins_for_page = Bulletin.paginate(bulletins)[page - 1] || []
    return bulletins_for_page
  end

  def relative_local_url
    url.present? ? url : "#/bulletins/#{slug}"
  end

  def shortened_url
    if Rails.env.production?
      client = Bitly.client
      client.shorten(relative_local_url).short_url
    end
  end

  def url_to_serialize
    Rails.env.production? ? shortened_url : relative_local_url
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
    if Rails.env.production?
      begin
        Twitter.update "#{self.title} - #{shortened_url}"
      rescue => e
        puts "#{e.inspect} - #{self.title}"
      end
    else
      puts "Tweeting #{self.title} in development"
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
end
