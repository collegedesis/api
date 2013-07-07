class MembershipApplication < ActiveRecord::Base
  attr_accessible :membership_type_id, :application_status_id, :user_id, :organization_id

  belongs_to :user
  belongs_to :organization

  validates_presence_of :membership_type_id
  validates_presence_of :application_status_id
  validates_presence_of :user_id
  validates_presence_of :organization_id
  validates :code, uniqueness: true, presence: true

  def approve
    new_membership = update_or_create_new_membership
    update_status(APP_STATUS_APPROVED)
    send_approved_notifications
  end

  def reject
    update_status(APP_STATUS_REJECTED)
    send_rejected_notifications
  end

  def dispatch_application_for_approval
    # does not run if organization auto approves memberships
    if application_status_id == APP_STATUS_PENDING
      OrganizationMailer.send_application(self).deliver
      MemberMailer.thank_you_for_applying(self).deliver
    end
  end

  def send_approved_notifications
    # notify all its members if admin application
    if admin_application?
      organization.memberships.each do |membership|
        if membership.user != self.user
          MemberMailer.notify_new_admin(self, membership)
        end
      end
    end
    # congratulate the member
    MemberMailer.approved_application(self).deliver
  end

  def send_rejected_notifications
    MemberMailer.rejected_application(self).deliver
  end

  def update_or_create_new_membership
    conditions = {organization_id: organization.id, user_id: user.id}
    membership = Membership.where(conditions).first || Membership.new(conditions)
    membership.membership_type_id = self.membership_type_id
    membership.approved           = true
    membership.save
  end

  def should_be_auto_approved?
    admin_application? ? false : organization.auto_approve_memberships
  end

  def admin_application?
    membership_type_id == MEMBERSHIP_TYPE_ADMIN
  end

  def update_status(new_status)
    self.update_attributes(application_status_id: new_status)
  end

  def application_type
    admin_application? ? "an Administrator" : "a Member"
  end

  def approval_url
    base_url + code + "/approve"
  end

  def rejection_url
    base_url + code + "/reject"
  end

  def base_url
    base = Rails.env.production? ? "https://collegedesis.com" : "http://localhost:3000"
    base + "/application/"
  end
end