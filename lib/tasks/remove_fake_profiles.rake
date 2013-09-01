task :remove_fake_profiles => :environment do
  User.all.each do |u|
    match = Organization.where('lower(email) = ? or lower(name) = ?', u.email.downcase, u.full_name.downcase)
    u.remove_fake_profile if match.length > 0
  end
end