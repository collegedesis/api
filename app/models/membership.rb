class Membership < ActiveRecord::Base
  attr_accessible :membership_type_id, :organization_id, :user_id
  validates_presence_of :organization_id
  validates_presence_of :user_id
  after_create :send_notifications

  belongs_to :user
  belongs_to :organization

  protected

  def notify
    if self.organization.email?
      member = self.user
      organization = self.organization
      OrganizationMailer.new_member_notification(member, organization).deliver
    end
    MemberMailer.welcome_email(self).deliver
  end
end