class MembershipObserver < ActiveRecord::Observer

  def after_create(membership)
    # send an email to the user
    MemberMailer.membership_welcome(membership).deliver
    # send an email to the organization
    OrganizationMailer.new_member(membership).deliver
    # send an email to admin
    AdminMailer.notify(membership).deliver
    # update user status
    membership.user.update_approved_status
  end

  def after_destroy(membership)
    # send an email to the organization
    MemberMailer.membership_rejected(membership).deliver
    # send an email to the organization
    OrganizationMailer.membership_rejected(membership).deliver
    # update user status
    membership.user.update_approved_status
  end
end