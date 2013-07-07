class Membership < ActiveRecord::Base
  attr_accessible :membership_type_id, :organization_id, :user_id, :approved
  validates_presence_of :organization_id

  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => :organization_id

  belongs_to :user, inverse_of: :memberships
  belongs_to :organization, inverse_of: :memberships
  delegate :display_name, to: :organization
  belongs_to :membership_type
end