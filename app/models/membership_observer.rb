class MembershipObserver < ActiveRecord::Observer

  def after_create(membership)
    # send an email to the user
    MemberMailer.welcome_email(membership).deliver
    # send an email to the organization
    OrganizationMailer.new_member(membership).deliver
  end
end