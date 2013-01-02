class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  has_many :memberships

  def name
    "#{first_name} #{last_name}"
  end
end