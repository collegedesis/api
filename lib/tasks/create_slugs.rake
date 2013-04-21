namespace :slugs do
  desc "Creates slugs for existing bulletins"
  task :create_bulletin_slugs => :environment do
    Bulletin.all.each do |b|
      b.slug = b.title.parameterize
      b.save(:validate => false)
    end
  end

  desc "Creates slugs for organizations"
  task :create_org_slugs => :environment do
    Organization.all.each do |o|
      puts "setting slug for #{o.display_name}"
      o.slug = o.display_name.parameterize
      o.save(:validate => false)
    end
  end
end