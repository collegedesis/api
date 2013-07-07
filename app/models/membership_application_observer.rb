class MembershipApplicationObserver < ActiveRecord::Observer

  def before_validation(app)
    if !app.code
      code = rand(1000).to_s
      app.code = Digest::MD5.hexdigest(code)
    end
  end

  def after_create(app)
    org = app.organization
    app.should_be_auto_approved? ? app.approve : app.dispatch_application_for_approval
  end
end