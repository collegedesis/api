class MembershipType < ActiveRecord::Base
  attr_accessible :name, :internal_ref
  has_many :memberships
end
