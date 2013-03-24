class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :password, :password_confirmation, :memberships_attributes
  attr_accessor :password

  validates_confirmation_of :password
  validates_presence_of :full_name
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  validates :memberships, :length => { :minimum => 1}

  has_many :memberships, inverse_of: :user
  accepts_nested_attributes_for :memberships, allow_destroy: true

  before_save :encrypt_password

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
end