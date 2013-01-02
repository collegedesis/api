class VerificationMailer < ActionMailer::Base

  def verify_email_address(email, code)
    @from = email
    @code = code
    mail(to: @from, from: 'brownkids@collegedesis.com', subject: "Your verification code is #{@code}")
  end
end