require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(30.minutes, 'Update popularity score') { Bulletin.all.each(&:update_score) }
every(1.hour, 'Tweeting top 3 bulletins') { BulletinTweeter.tweet_top(3) }
every(1.day, 'expire bulletins', at: '23:59') { Bulletin.alive.each(&:expire) }
