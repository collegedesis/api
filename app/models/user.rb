class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :password, :password_confirmation, :memberships_attributes, :approved
  attr_accessor :password

  validates_confirmation_of :password
  validates_presence_of :full_name
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :memberships, :dependent => :destroy
  has_many :bulletins, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  before_save :encrypt_password

  require 'digest/md5'

  def confirm_password?(password)
    return false unless self.password_hash && self.password_salt
    self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def avatar_url
    hash = Digest::MD5.hexdigest(email.downcase)
    "//www.gravatar.com/avatar/#{hash}"
  end

  def update_approved_status
    val = has_approved_membership? ? true : false
    self.update_attributes(approved: val)
  end

  protected
  def has_approved_membership?
    memberships.map(&:approved).include? true
  end
end