class MembershipObserver < ActiveRecord::Observer

  def create(membership)
    membership.user.update_approved_status
  end

  def after_destroy(membership)
    # send an email to the member
    MemberMailer.membership_rejected(membership).deliver
    # update user status
    membership.user.update_approved_status
  end

end