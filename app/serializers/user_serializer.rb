class UserSerializer < ApplicationSerializer
  attributes :id, :full_name, :image_url, :approved, :bio, :username

  has_many :memberships
  has_many :bulletins
  has_many :membership_applications
end