class Organization < ActiveRecord::Base
  validates_presence_of :name, :university_id, :organization_type_id
  validates_uniqueness_of :email, allow_nil: true
  validates_uniqueness_of :slug, allow_nil: true

  after_create :send_welcome_email
  attr_accessible :name, :university_id, :organization_type_id, :email, :website, :exposed, :slug

  belongs_to :organization_type
  belongs_to :university
  has_many :emails
  has_many :events
  has_many :memberships

  default_scope order('name ASC')
  scope :exposed, where(:exposed => true)
  scope :with_email, :conditions => "email IS NOT NULL"

  def has_email?
    self.email? ? true : false
  end

  def display_name
    if university
      "#{name} (#{university.name})"
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
protected
  def send_welcome_email
    OrganizationMailer.welcome(self).deliver if self.email?
  end
end
