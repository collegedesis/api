require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(1.hours, 'Update popularity score') { Bulletin.all.each(&:update_score) }
every(4.hours, 'Tweeting top 3 bulletins') { BulletinTweeter.tweet_top(3) }
every(1.day, 'expire bulletins', at: '23:59') { Bulletin.alive.each(&:expire) }