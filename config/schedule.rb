set :output, "#{path}/log/cron.log"

every 6.hours do
  rake "bulletins:tweet_top_five"
end