class OrganizationMailer < ActionMailer::Base
  default from: "CollegeDesis <brownkids@collegedesis.com>"

  def welcome(org)
    @org = org
    mail(to: org.email, subject: 'You\'re in the CollegeDesis directory!')
  end

  def update_notification(org)
    @org = org
    mail(to: org.email, subject: 'Your CollegeDesis directory info was updated')
  end

  def confirm_event_create(event)
    @event = event
    @org = event.organization
    mail(to: @org.email, subject: 'You\'re hosting #DesiBeatsSunday!')
  end

  def new_member(membership)
    @member = membership.user
    @org = membership.organization
    mail(to: @org.email, subject:'You have a new member!')
  end

  def earnings_notification(org, product)
    @org = org
    @product = product
    mail(to: @org.email, subject: "#{@org.name} just earned $#{@product.beneficiary_payout.to_i}", )
  end
end