class CampaignMailer < ActionMailer::Base
  def send_email(msg, org)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @org = org
    @msg = msg
    sender = "\"#{msg.from_name}\" <#{@msg.from_email}>"
    mail(to: org.email, from: sender, subject: @msg.subject)
  end

  def send_test(body, subject, sender_name, sender_email)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @body = body
    @sender_email = sender_email
    sender = "\"#{sender_name}\" <#{sender_email}>"
    mail(to: sender_email, from: sender, subject: subject)
  end
end