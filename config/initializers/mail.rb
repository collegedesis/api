ActionMailer::Base.smtp_settings = {
  :authentication => 'login',
  :address   => "smtp.mandrillapp.com",
  :port      => 25,
  :user_name => ENV["MANDRILL_USERNAME"],
  :password  => ENV["MANDRILL_API_KEY"]
}