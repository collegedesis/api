class Bulletin < ActiveRecord::Base
  include Slugify

  attr_accessible :body, :title, :url, :bulletin_type, :user_id, :slug, :is_dead, :shortened_url, :score, :high_score, :expired, :expiration_date, :author_id, :author_type
  before_save :normalize_title, :create_slug
  before_create :set_short_url, :set_expiration_date, :assign_smart_body

  has_many :votes, :as => :votable, :dependent => :destroy

  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user
  belongs_to :author, polymorphic: true
  # bulletin_types:
  # post is 1
  # link is 2

  validates_presence_of :title
  validates_presence_of :body, :if => :is_post?
  validates_presence_of :url, :if => :is_link?
  validates_presence_of :user_id
  validates_presence_of :author_id
  validates_uniqueness_of :url, :allow_nil => true, :allow_blank => true

  scope :alive, where(expired: false)
  scope :homepage, -> { recent.where('author_id IS NOT NULL and is_dead = ?', false).order('score DESC') }
  scope :recent, where(" created_at > ?", 10.days.ago)

  def self.find_by_title(title)
    Bulletin.where("lower(title) = lower(:title)", :title => title).first
  end

  def expire
    val = should_be_expired?
    update_attributes(expired: val)
  end

  def update_score
    scorekeeper = BulletinScoreKeeper.new(self)
    scorekeeper.update_score
  end

  def should_be_expired?
    self.expiration_date.to_date <= Date.current.to_date
  end

  def is_link?
    bulletin_type == BULLETIN_TYPE_LINK
  end

  def is_post?
    bulletin_type == BULLETIN_TYPE_POST
  end

  def relative_local_url
    "n/#{slug}"
  end

  def promote
    orgs = Organization.reachable
    orgs.each do |org|
      OrganizationMailer.bulletin_promotion(self, org).deliver
    end
  end

  def voted_by_user?(user)
    votes.map(&:user_id).include? user.id
  end

  def tweet
    tweeter = BulletinTweeter.new(self)
    tweeter.tweet
  end

  def approved?
    user.approved?
  end

  private

  def assign_smart_body
    # if the url is a youtube link,
    # assign the body with the showdown markdown
    # for rendering youtube links
    regex = /((http|https):\/\/)?(www\.)?(youtube\.com)(\/)?([a-zA-Z0-9\-\.]+)\/?/
    self.body = "^^#{url}" if regex.match(url)
  end

  def set_short_url
    if Rails.env.production?
      client = Bitly.client
      to_shorten = "https://collegedesis.com/" + relative_local_url
      self.shortened_url = client.shorten(to_shorten).short_url
    end
  end

  def normalize_title
    if title == title.upcase || title == title.downcase
      self.title = title.split.map(&:capitalize).join(' ')
    end
  end

  def set_expiration_date
    if !self.expiration_date
      if self.created_at?
        self.expiration_date = self.created_at + 2.days
      else
        self.expiration_date = Date.current + 2.days
      end
    end
  end
end
