class Organization < ActiveRecord::Base
  include Slugify

  validates_presence_of :name, :university_id, :organization_type_id
  validates_uniqueness_of :email, allow_nil: true
  validates_uniqueness_of :slug, allow_nil: true
  before_create :create_slug
  after_create :send_welcome_email
  attr_accessible :name, :university_id, :organization_type_id, :email, :website, :exposed, :slug, :about, :twitter, :facebook, :youtube, :instagram

  belongs_to :organization_type
  belongs_to :university
  has_many :emails
  has_many :events
  has_many :memberships
  has_many :membership_applications

  has_many :bulletins, :as => :author, :dependent => :destroy
  default_scope order('organizations.name ASC')
  scope :reachable, conditions: 'email IS NOT NULL'
  scope :exposed, conditions: 'exposed'


  def approved_membership_ids
    memberships.where(approved: true).select(:id).map(&:id)
  end

  def has_email?
    self.email? ? true : false
  end

  def display_name
    str = name
    str.prepend("#{university_name} - ") if university_name
    return str
  end

  def directory_profile
    base = "https://collegedesis.com/#"
    slug ? "#{base}/d/#{slug}" : "#{base}/directory"
  end

  def location
    university.state if university
  end

  def university_name
    university.name if university
  end

  def self.filter_and_search_by_query(query)
    states = query[:states] || []
    param = query[:param]
    # if both states and param
    query_results = if states.present? && param.present?
      Organization.eager_load(:university).where('organizations.name like ? AND universities.state IN (?)', "%#{param}%", states)
    # if states but not param
    elsif states.present? && param.blank?
      Organization.eager_load(:university).where('universities.state IN (?)', states)
    # if para but not states
    elsif states.empty? && param.present?
      Organization.where('name like ?', "%#{param}%")
    elsif states.empty? && param.blank?
      []
    end
    return query_results
  end

  def self.filter_by_params(params)
    orgs = Organization.eager_load(:university)
    if params[:type]
      orgs = Organization.eager_load(:university).reachable.exposed
      type = OrganizationType.where("lower(name) = ?", params[:type].downcase).first
      orgs = orgs.reachable.where(organization_type_id: type.id)
    end
    return orgs
  end

  def reputation
    100
  end

protected
  def send_welcome_email
    OrganizationMailer.welcome(self).deliver if self.email?
  end
end
