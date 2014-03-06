class Bulletin < ActiveRecord::Base
  include Slugify

  attr_accessible :body, :title, :url, :user_id, :slug, :is_dead, :score,
                  :high_score, :expired, :expiration_date, :author_id,
                  :author_type

  before_save :normalize_title, :create_slug
  before_create :set_expiration_date, :assign_smart_body

  before_validation :assign_title

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy
  belongs_to :user
  belongs_to :author, polymorphic: true

  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :author_id
  validates_uniqueness_of :url, allow_nil: true, allow_blank: true

  scope :alive,     -> { where(expired: false) }
  scope :homepage,  -> { recent.where('author_id IS NOT NULL and is_dead = ?', false).order('score DESC') }
  scope :recent,    -> { where(" created_at > ?", 10.days.ago) }

  def self.find_by_title(title)
    Bulletin.where("lower(title) = lower(:title)", title: title).first
  end

  def author_name
    if author_type == "Organization"
      author.display_name
    elsif  author_type == "User"
      author.full_name
    end
  end

  def update_score
    scorekeeper = BulletinScoreKeeper.new(self)
    scorekeeper.update_score
  end

  def should_be_expired?
    self.expiration_date.to_date <= Date.current.to_date
  end

  def promote(orgs)
    orgs = orgs.present? ? orgs.reachable : Organization.reachable
    orgs.each do |org|
      OrganizationMailer.bulletin_promotion(self, org).deliver
    end
  end

  def tweet
    BulletinTweeter.new(self).tweet
  end

  # to facebook
  def post
    BulletinFacebookPoster.new(self).post
  end

  def approved?
    user.approved?
  end

  def shareable_link
    base = if Rails.env.production?
     "https://news.collegedesis.com/"
   else
      "http://localhost:3000/"
    end
    base + "news/#{slug}"
  end

  private

  def assign_smart_body
    # if the url is a youtube link,
    # assign the body with the showdown markdown
    # for rendering youtube links
    youtube_regex = /((http|https):\/\/)?(www\.)?(youtube\.com)(\/)?([a-zA-Z0-9\-\.]+)\/?/
    if youtube_regex.match(url)
      self.body = "^^#{url}"
    end

    image_regex = /^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpe?g|gif|png)$/
    if image_regex.match(url)
      self.body = "![#{title}](#{url})"
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

  def assign_title
    if self.title.blank?
      agent = Mechanize.new
      agent.follow_meta_refresh = true
      begin
        title = agent.get(self.url).title
        self.title = title
      rescue => e
        puts "Error Assigning Title for #{self.url}: #{e.inspect}"
      end
    end
  end
end
