class MembershipObserver < ActiveRecord::Observer

  def after_create(membership)
    # send an email to the user
    MemberMailer.membership_welcome(membership).deliver
    # send an email to the organization
    OrganizationMailer.new_member(membership).deliver
    # send an email to admin
    AdminMailer.notify(membership).deliver
  end
end