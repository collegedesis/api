task :create_slugs => :environment do
  Bulletin.all.each do |b|
    b.slug = b.title.parameterize
    b.save(:validate => false)
  end
end