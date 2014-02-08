class AdminMailer < ActionMailer::Base
  default from: "CollegeDesis <brownkids@collegedesis.com>"
  def notify(membership)
    mail(
      to: "notify@collegedesis.com",
      subject: "#{membership.user.full_name} registered via #{membership.organization.display_name}",
      body: "Using email address: #{membership.user.email}"
    )
  end
end