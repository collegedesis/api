class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :memberships_attributes,
                  :approved, :image_url, :bio, :username,
                  :password, :password_confirmation, :password_digest

  validates_presence_of :full_name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :bulletins, as: :author, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :membership_applications, dependent: :destroy

  before_create :assign_image_url

  has_many :api_keys

  require 'digest/md5'

  def session_api_key
    api_keys.active.session.first_or_create
  end

  def confirm_password?(password)
    return false unless self.password_hash && self.password_salt
    self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
  end

  def update_approved_status
    val = has_approved_membership? ? true : false
    self.update_attributes(approved: val)
  end

  def is_admin_of?(org)
    membership = get_membership(org)
    if membership && (membership.membership_type_id == MEMBERSHIP_TYPE_ADMIN)
      true
    else
      false
    end
  end

  def is_member_of?(organization)
    memberships.map(&:organization_id).include?(organization.id)
  end

  def remove_fake_profile
    self.memberships.destroy_all
    self.membership_applications.destroy_all
    self.comments.destroy_all
    # Destroy all bulletins post as self or as an organization
    Bulletin.where('user_id = ? or author_id = ?', self.id, self.id).destroy_all
    MemberMailer.send_violation_notice(self).deliver
    self.destroy
  end

  protected
  def get_membership(org)
    memberships.where(organization_id: org.id).first
  end

  def has_approved_membership?
    memberships.map(&:approved).include? true
  end

  def assign_image_url
    hash = Digest::MD5.hexdigest(email.downcase)
    self.image_url = "//www.gravatar.com/avatar/#{hash}"
  end
end