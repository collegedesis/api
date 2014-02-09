def random_author
  authors = User.all.concat(Organization.all)
  return authors.sample
end

puts "Creating 3 Universities"
University.where(name: "Rutgers University", city: "Newark", state: "NJ").first_or_create
University.where(name: "Northwestern University", city: "Evanston", state: "IL").first_or_create
University.where(name: "University of California - Berkeley", city: 'Berkeley', state: "CA").first_or_create


puts 'Creating Organizations'
20.times do |i|
  print "#{i} "
  uni_id = University.all.sample.id
  org_type_id = OrganizationType.all.sample.id
  Organization.create(name: "Best Org #{i}", university_id: uni_id, organization_type_id: org_type_id, email: "fake#{i}@fake.net")
end
puts "\n"

puts 'Creating CollegeDesis'
cdes = Organization.new
cdes.name = "CollegeDesis"
cdes.organization_type_id = 1
cdes.email = "test@collegedesis.com"
cdes.save(validate: false)

puts 'Creating Users'
admin = User.create(full_name: "Admin User", email: "admin@admin.com", password: "secret", password_confirmation: "secret", bio: "Lorem ipsum...", username: "admin")

puts 'Creating Memberships'

orgs = Organization.all.sample(3)
orgs.each_with_index do |org, i|
  print "#{i} "
  MembershipApplication.create(user_id: User.first.id, organization_id: org.id, membership_type_id: MEMBERSHIP_TYPE_MEMBER)
end
puts "\n"

puts 'Creating bulletins'
urls = [
  "http://collegedesis.com",
  "http://google.com",
  "http://twitter.com",
  "http://facebook.com",
  "http://stackoverflow.com",
]

urls.each_with_index do |url, i|
  author = random_author
  print "#{i} "
  Bulletin.create(url: url, author_id: author.id, author_type: author.class.to_s, user_id: admin.id)
end
puts "\n"
