require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(30.minutes, 'Update popularity score') do
  Bulletin.all.each(&:update_score)
end

every(2.hour, 'Tweeting top 3 bulletins') do
  BulletinTweeter.tweet_top(3)
end

every(1.day, 'Posting top bulletin to Facebook', at: '18:00') do
  BulletinFacebookPoster.post_top_bulletin
end

every(1.day, 'expire bulletins', at: '23:59') do
  Bulletin.alive.each(&:expire)
end