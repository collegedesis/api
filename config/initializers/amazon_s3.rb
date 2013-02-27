# ENV variables set at Heroku config variables
# AWS Settings
if Rails.env == "production"
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['S3_ACCESS_KEY'],
    :secret_access_key => ENV['S3_SECRET']
  )
end