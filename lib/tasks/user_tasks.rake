namespace :users do
  desc "Remove fake profiles"
  task remove_fake: :environment do
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

  desc "Add gravatar images to user accounts"
  task gravatar: :environment do
    User.all.each do |u|
      hash = Digest::MD5.hexdigest(u.email.downcase)
      url = "//www.gravatar.com/avatar/#{hash}"
      puts "Updating #{u.full_name}: u.url"
      u.update_attributes(image_url: url)
    end
  end
end