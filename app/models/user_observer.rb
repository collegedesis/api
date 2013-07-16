class UserObserver < ActiveRecord::Observer
  def after_create(user)
    MemberMailer.welcome_email(user).deliver
    begin
      text_team(user)
    end
  end

  def text_team(user)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    if account_sid && auth_token
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      @twilio_client.account.sms.messages.create(
        :from => "+16418146200",
        :to => "+19712642651",
        :body => "Woot! #{user.full_name} just signed up!"
      )
    end
  end
end