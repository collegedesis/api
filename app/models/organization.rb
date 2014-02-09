class Organization < ActiveRecord::Base
  include Slugify
  searchkick
  validates_presence_of :name, :university_id, :organization_type_id
  validates_uniqueness_of :email, allow_nil: true
  validates_uniqueness_of :slug, allow_nil: true
  before_create :create_slug
  after_create :send_welcome_email
  attr_accessible :name, :university_id, :organization_type_id,
                  :email, :website, :exposed, :slug, :about, :twitter,
                  :facebook, :youtube, :instagram

  belongs_to :organization_type
  belongs_to :university
  has_many :emails
  has_many :events
  has_many :memberships
  has_many :membership_applications

  has_many :bulletins, as: :author, dependent: :destroy
  default_scope         { order('organizations.name ASC') }
  scope :reachable, ->  { where('email IS NOT NULL') }
  scope :exposed,   ->  { where(exposed: true) }

  def has_email?
    self.email? ? true : false
  end

  def display_name
    if university_name
      "#{university_name} - #{name}"
    else
      name
    end
  end

  def directory_profile
    base = "https://collegedesis.com"
    slug ? "#{base}/d/#{slug}" : "#{base}/directory"
  end

  def location
    university.state if university
  end

  def university_name
    university.name if university
  end

  def search_data
    {
      name: name,
      location: location,
      organization_type: organization_type.name,
      category: organization_type.category,
      university_name: university_name
    }
  end

  def self.filter_and_search_by_query(states, query)
    # if both states and query
    query_results = if states.present? && query.present?
      Organization.search(query).results.select do |result|
        result if states.include? result.location
      end
    # if states but not query
    elsif states.present? && query.blank?
      Organization.eager_load(:university).where('universities.state IN (?)', states)
    # if query but not states
    elsif states.empty? && query.present?
      Organization.search(query).results
    elsif states.empty? && query.blank?
      []
    end
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
    (memberships.length + bulletins.length) * 100
  end

protected
  def send_welcome_email
    OrganizationMailer.welcome(self).deliver if self.email?
  end
end
