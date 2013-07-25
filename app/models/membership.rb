class Membership < ActiveRecord::Base
  attr_accessible :membership_type_id, :organization_id, :user_id, :approved
  validates_presence_of :organization_id

  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => :organization_id

  belongs_to :user, inverse_of: :memberships
  belongs_to :organization, inverse_of: :memberships
  delegate :display_name, to: :organization
  belongs_to :membership_type

  def self.create_and_approve_with_application(app)
    conditions = {
      organization_id: app.organization.id,
      user_id: app.user.id
    }
    membership = Membership.where(conditions).first || Membership.new(conditions)
    membership.membership_type_id = app.membership_type_id
    membership.approved = true
    membership.save
    return membership
  end
end