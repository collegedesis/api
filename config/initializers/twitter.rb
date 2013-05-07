# These are set as config variables on heroku
# You can access them from the Heroku CLI Toolbelt with `heroku config`
# https://devcenter.heroku.com/articles/config-vars
Twitter.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_SECRET']
end