class AdminMailer < ActionMailer::Base
  default from: "CollegeDesis <brownkids@collegedesis.com>"
  def notify(membership)
    mail(to: "notify@collegedesis.com", subject: "#{membership.user.full_name} registered via #{membership.organization.name}" )
  end

  def application_notify(answers, address, recipient)
    @answers = answers
    @recipient = recipient
    mail(to: address, subject: "Thank you for applying")
  end
end