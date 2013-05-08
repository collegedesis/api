# Mailgun settings
ActionMailer::Base.smtp_settings = {
  :authentication           => :plain,
  :address                  => "smtp.mailgun.org",
  :port                     => 587,
  :domain                   => ENV['MAILGUN_DOMAIN'],
  :user_name                => ENV['MAILGUN_USER'],
  :password                 => ENV['MAILGUN_PASSWORD']
}