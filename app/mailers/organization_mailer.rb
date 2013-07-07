class OrganizationMailer < ActionMailer::Base
  default from: "CollegeDesis <brownkids@collegedesis.com>"

  def welcome(org)
    @org = org
    mail(to: org.email, subject: 'You\'re in the CollegeDesis directory!')
  end

  def new_member(member, org)
    @member = member
    @org = org
    mail(to: @org.email, subject:"#{member.full_name} is a new member!")
  end

  def bulletin_promotion(bulletin, org)
    @bulletin = bulletin
    @org = org
    mail(to: @org.email, subject: "#{@bulletin.title} via CollegeDesis")
  end

  def send_application(application)
    @user = application.user
    @org = application.organization
    @app = application
    mail(to: @org.email, subject: "#{@user.full_name} applied to be #{@app.application_type}")
  end
end