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

  def has_email?
    self.email? ? true : false
  end

  def url
    "//collegedesis.com/directory#/#{self.id}"  
  end

  def display_name
    "#{name} (#{university.name})"
  end

protected
  def send_welcome_email
    OrganizationMailer.welcome(self).deliver if self.email?
  end
end
