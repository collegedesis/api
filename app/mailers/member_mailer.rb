class MemberMailer < ActionMailer::Base
  default from: "CollegeDesis <brownkids@collegedesis.com>"

  def membership_welcome(membership)
    @member = membership.user
    @org = membership.organization
    mail(to: @member.email, subject: "You've joined #{@org.name}!")
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to CollegeDesis!")
  end

  def membership_rejected(membership)
    @user = membership.user
    @org = membership.organization
    mail(to: @user.email, subject: "Your membership to #{@org.name} was removed")
  end

  def rejected_application(application)
    @user = application.user
    @org = application.organization
    @app = application
    mail(to: @user.email, subject: "Your application to #{@org.name} was rejected")
  end

  def approved_application(application)
    @user = application.user
    @org = application.organization
    @app = application
    mail(to: @user.email, subject: "Your application to #{@org.name} was approved!")
  end

  def thank_you_for_applying(app)
    @app = app
    mail(to: @app.user.email, subject: "#{@app.organization.name} got your application to be #{@app.application_type}!")
  end

  def notify_new_admin(app, membership)
    @app = app
    @admin = app.user
    @membership = membership
    mail(to: @app.user.email, subject: "#{@admin.full_name} is an administrator of #{@membership.organization.name}")
  end

  def send_violation_notice(user)
    @user = user
    @org = Organization.where('lower(email) = ? or lower(name) = ?', user.email.downcase, user.full_name.downcase).first
    if @user && @org
      mail(to: @user.email, subject: "Your user account has been deleted for violating our policies")
    end
  end
end