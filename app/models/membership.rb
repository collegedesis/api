class Membership < ActiveRecord::Base
  attr_accessible :membership_type_id, :organization_id, :user_id, :approved
  validates_presence_of :organization_id
  validates_presence_of :user

  belongs_to :user, inverse_of: :memberships
  belongs_to :organization, inverse_of: :memberships
  before_create :auto_approve
  delegate :display_name, to: :organization

  protected

  def auto_approve
    self.approved = organization.auto_approve_memberships
  end

  def notify
    if self.organization.email?
      member = self.user
      organization = self.organization
      OrganizationMailer.new_member_notification(member, organization).deliver
    end
    MemberMailer.welcome_email(self).deliver
  end
end