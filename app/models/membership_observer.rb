class MembershipObserver < ActiveRecord::Observer

  def after_create(membership)
    membership.user.update_approved_status
    AdminMailer.notify(membership).deliver
    OrganizationMailer.new_member(membership).deliver if membership.approved?
  end
end
