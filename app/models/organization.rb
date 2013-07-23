class Organization < ActiveRecord::Base
  include Slugify
  validates_presence_of :name, :university_id, :organization_type_id
  validates_uniqueness_of :email, allow_nil: true
  validates_uniqueness_of :slug, allow_nil: true
  before_create :create_slug
  after_create :send_welcome_email
  attr_accessible :name, :university_id, :organization_type_id, :email, :website, :exposed, :slug, :about, :twitter, :facebook, :youtube

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
    memberships.select {|m| m if m.approved? }.map(&:id)
  end

  def has_email?
    self.email? ? true : false
  end

  def display_name
    if university
      "#{university.name} - #{name}"
    else
      name
    end
  end

  def location
    university.state if university
  end

  def university_name
    university.name if university
  end

  def self.filter_and_search_by_query(query)
    states = query[:states]
    param = query[:param].downcase
    like_param = "%#{param}%"
    # binding.pry
    orgs = if param.present? && states.present?
      Organization.eager_load(:university).where("universities.state in (?) and lower(organizations.name) like ?", states, like_param)
    elsif param.blank? && states.present?
      Organization.eager_load(:university).where("universities.state in (?)", states)
    elsif param.present? && states.blank?
      Organization.eager_load(:university).where("lower(organizations.name) like ?", like_param)
    elsif param.blank? && states.blank?
      []
    end
    return orgs
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

  def self.filter_by_states(states)
    if states.length
      Organization.eager_load(:university).where("universities.state in (?)", states)
    else
      Organization.eager_load(:university)
    end
  end

  def reputation
    100
  end

protected
  def send_welcome_email
    OrganizationMailer.welcome(self).deliver if self.email?
  end
end
