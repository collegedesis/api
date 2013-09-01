desc "Remove fake profiles"
task :remove_fake_profiles => :environment do
  User.all.each do |u|
    puts "Checking #{u.full_name}: #{u.email}"
    match = Organization.where('lower(email) = ? or lower(name) = ?', u.email.downcase, u.full_name.downcase)
    if match.length > 0
      puts "Removing #{u.full_name}: #{u.email}"
      u.remove_fake_profile
      puts ""
    end
  end
end