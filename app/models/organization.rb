class Organization < ActiveRecord::Base
  validates_presence_of :name, :university_id, :organization_type_id
  validates_uniqueness_of :email, allow_nil: true
  after_create :send_welcome_email
  attr_accessible :name, :university_id, :organization_type_id, :email, :website, :public

  belongs_to :organization_type
  belongs_to :university
  has_many :emails
  has_many :events
  has_many :memberships

  default_scope order('name ASC')
  scope :public, where(:public => true)

  require 'csv'

  def has_email?
    self.email? ? true : false
  end

  def url
    "//collegedesis.com/directory#/#{self.id}"  
  end

  def display_name
    "#{name} (#{university.name})"
  end

def self.load_organizations(file)
  str = File.read(file)
  rows = CSV.parse(str)
  # header = ["name", "university", "org_type", "state", "email", "website"]
  header = rows.shift #removes header

  rows.each do |row|
    name          = row[0]
    university    = row[1]
    org_type      = row[2]
    state         = row[3]
    email         = row[4]
    website       = row[5]

    if email
      newOrg = Organization.find_or_initialize_by_email(email)
      newOrg.name                   = name
      newOrg.university             = university
      newOrg.organization_type_id   = org_type
      newOrg.state                  = state
      newOrg.email                  = email
      newOrg.website                = website
    else
      newOrg = Organization.new(
        name: name,
        university: university,
        organization_type_id: org_type,
        state: state,
        website: website
        )
    end
    newOrg.save
  end
end


protected
  def send_welcome_email
    if self.email?
      OrganizationMailer.welcome(self).deliver
    end
  end
end
