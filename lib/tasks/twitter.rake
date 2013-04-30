namespace :bulletins do
  desc "Tweet top 5 bulletins"
  task :tweet_top_five => :environment do
    Bulletin.top_five.each { |b| b.tweet }
  end
end