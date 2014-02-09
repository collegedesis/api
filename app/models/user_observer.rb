class UserObserver < ActiveRecord::Observer
  def after_create(user)
    MemberMailer.welcome_email(user).deliver
  end
end